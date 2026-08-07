# 15 — Paridade web ↔ Flutter

O Nortear DS existe em 4 stacks de navegador e agora em Flutter. Compartilhar
tokens e conteúdo é barato; compartilhar comportamento não é. Esta guideline
define o que precisa ser igual, o que precisa ser equivalente e o que não
atravessa.

Sem essa separação escrita, um dos dois erros acontece: ou o Flutter vira
tradução literal do DOM (e fica estranho no celular), ou diverge sem controle e
deixa de ser o mesmo sistema.

## A referência não é o Vanilla

No repo web, o Vanilla é a referência cross-stack — em divergência de markup ou
classe, ele está certo. **Isso não se estende ao Flutter.** Não há markup a ser
referência: não existe DOM, não existe cascade, não existe hover.

A referência do Flutter é o **Material 3 mais a intenção semântica do sistema**.
Quando o Material e a web discordam sobre mecânica, o Material ganha. Quando
discordam sobre significado — o que é destrutivo, o que é primário, que texto o
leitor de tela ouve — o sistema ganha.

## Os três níveis

Todo componente é classificado em um deles, e a classificação vai na docs page.

### Nível 1 — Idêntico

Diverge, é bug.

- Tokens: cor, raio, espaçamento, tipografia, duração e curva saem do mesmo
  `@nortear/ds-core`. Se o botão do Flutter usa outro azul, é defeito.
- Hierarquia semântica: o que é primário na web é primário aqui.
- Tom de voz e UX writing (guideline 05).
- Taxonomia das seções da documentação (guideline 14).
- Critérios de acessibilidade em nível de intenção: todo controle tem nome
  acessível, todo estado é anunciado, ninguém depende só de cor.

### Nível 2 — Equivalente

Mesmo trabalho, mecânica diferente. A docs page **não promete paridade visual**;
descreve o que o componente resolve e mostra a forma nativa.

| Web | Flutter | Por quê |
|---|---|---|
| `hover-card` | long-press | não há ponteiro |
| `tooltip` | `Tooltip` (long-press) | idem |
| `sheet` / `drawer` | `showModalBottomSheet` / `Drawer` | convenção da plataforma |
| `sonner` (toast) | `SnackBar` / `Overlay` | posição e dispensa são do SO |
| `popover` | `MenuAnchor` / `OverlayPortal` | ancoragem é da árvore, não do CSS |
| `command` (⌘K) | busca em tela cheia | não há atalho de teclado no celular |
| `dropdown-menu` | `MenuAnchor` / `showMenu` | idem |
| `scroll-area` | `Scrollbar` + `ScrollView` | barra é do SO, não estilizável igual |

Regra de escrita: em nível 2, a descrição diz **o que o componente faz**, nunca
o gesto da outra plataforma. "Revela informação complementar sem sair da tela" —
não "equivalente ao hover da web".

### Nível 3 — Só de um lado

Existe em um e não no outro. Não force.

**Só na web** — `resizable`, `menubar`, `context-menu` (clique direito),
`sidebar` colapsável, `aspect-ratio` como componente (no Flutter é o widget
`AspectRatio`, não um componente do sistema).

**Só no Flutter** — `NavigationBar` inferior, pull-to-refresh, `SegmentedButton`,
FAB, action sheet, swipe actions em lista, háptica, safe area, recuo de teclado.

Componente nível 3 do lado Flutter precisa de conteúdo **novo** em
`translations.json`, com as três línguas. Não é tradução de nada.

## Tokens que não atravessam

Levantado ao gerar o Dart a partir do `@nortear/ds-core`:

| Token | Situação |
|---|---|
| `Camada` (z-index) | **Não porta.** Ordem de pintura no Flutter é a árvore de widgets e o `Overlay`. Um inteiro de z-index não tem onde ser aplicado. Coleção excluída do gerador. |
| `curva` (`cubic-bezier`) | Porta **traduzido** para `Cubic`. Como string CSS seria inerte. |
| `duracao` (ms) | Porta **traduzido** para `Duration`. |
| `Elevacao` (`box-shadow`) | Porta **traduzido** para `List<BoxShadow>`. |
| `letter-spacing` (`em`) | Porta **parcialmente**. `TextStyle.letterSpacing` é em pixels lógicos; a conversão depende do `fontSize`, então o token sai com sufixo `Em` e quem multiplica é a camada de tema. |

Regra: token que chega em sintaxe de navegador é traduzido no gerador, nunca
carregado como `String` para o componente resolver. Se não há tradução possível,
a coleção fica fora e o motivo vem para esta tabela.

## Interação e alvo de toque

Três diferenças que mudam o layout, não só o estilo:

**Estados.** `hover` e `focus-visible` deixam de ser primários. A hierarquia
nativa é: repouso → pressionado (com ripple) → desabilitado → focado. Foco de
teclado continua importando — web, desktop e teclado externo no tablet — mas não
define a aparência padrão.

**Alvo de toque.** 48dp no Material, 44pt no iOS, contra 24px de mínimo na web.
O padding vertical dos tokens **não é herdado direto**: ele é o piso visual, e o
alvo é garantido por `BoxConstraints(minHeight: 48)`.

**Escala de texto.** É a leitura Flutter do WCAG 1.4.4 e a razão de a regra
"nunca altura fixa em primitivo" valer aqui igual. `height:` fixo corta o texto
quando o usuário aumenta a fonte do sistema. Todo primitivo tem teste em
`TextScaler.linear(2.0)`, e o `TextScaleAddon` do Widgetbook deixa isso visível
sem abrir o app.

## Acessibilidade

O que muda de nome, não de intenção:

| Web | Flutter |
|---|---|
| `aria-label` | `Semantics(label:)` |
| `aria-hidden` | `ExcludeSemantics` |
| agrupar rótulo e controle | `MergeSemantics` |
| live region | `SemanticsService.announce` |
| `prefers-reduced-motion` | `MediaQuery.disableAnimationsOf` |
| `prefers-contrast` | `MediaQuery.highContrastOf` |
| zoom de texto | `MediaQuery.textScalerOf` |
| axe-core | `meetsGuideline(...)` do `flutter_test` |

`axe` não tem equivalente exato: os `meetsGuideline` cobrem alvo de toque,
rótulo e contraste, e param aí. O resto — ordem de foco, anúncio de estado,
agrupamento — é teste escrito à mão, não varredura automática. Documentar
cobertura de a11y como "passa no automático" seria promessa falsa.
