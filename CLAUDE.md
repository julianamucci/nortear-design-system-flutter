# CLAUDE.md

Guia para o Claude Code (claude.ai/code) neste repositório.

## O que é

Nortear Design System em Flutter. Consome o `@nortear/ds-core` — os tokens, o
conteúdo trilíngue e as guidelines do monorepo web — e implementa os componentes
com o modelo de interação nativo.

**Não é uma porta do repo web.** O que é compartilhado são tokens e conteúdo, não
markup nem comportamento. Antes de implementar qualquer componente, leia
`docs/guidelines/15-paridade-web-flutter.md`: ela classifica cada componente em
idêntico / equivalente / só de um lado, e define o que nunca deve ser traduzido
literalmente.

## Layout

```
packages/
  nortear_ds/              # pacote consumível
    lib/src/tokens/*.g.dart   # GERADO — não editar
    lib/src/theme/            # NdsTheme (ThemeExtension) + NortearTheme
    lib/src/components/       # widgets
    test/                     # unit + a11y
  nortear_ds_widgetbook/   # workbench, NÃO publicado
    lib/use_cases/            # @widgetbook.UseCase por componente
tool/                      # Node: sync do ds-core + geração dos tokens
docs/guidelines/           # regras próprias do Flutter
.ds-core/                  # cópia local do ds-core (gitignored)
```

**Os dois pacotes são separados de propósito.** `widgetbook`, `build_runner` e
`widgetbook_generator` não podem entrar no grafo de dependências de quem consome
o design system. É o equivalente Flutter de "Storybook é dev-only" — se um dia
alguém precisar adicionar `widgetbook` ao `nortear_ds/pubspec.yaml`, a resposta
é não; o caso pertence ao pacote do workbench.

## Comandos

```bash
# Tokens (Node — não precisa de Flutter)
npm run core:sync         # traz o @nortear/ds-core para .ds-core/
npm run tokens:gen        # .ds-core/tokens/figma-variables.json → Dart
npm run tokens:check      # falha se o Dart commitado estiver defasado

# Flutter
cd packages/nortear_ds && flutter test
cd packages/nortear_ds && flutter analyze

# Workbench
cd packages/nortear_ds_widgetbook
dart run build_runner build    # gera main.directories.g.dart
flutter run -d chrome
```

## Convenções

- **Nunca editar `lib/src/tokens/*.g.dart`.** São gerados. Mexeu em token, mexa
  no repo web, rode `core:sync` e `tokens:gen`. O CI roda `tokens:check` e
  falha se o commitado divergir da fonte.
- **Nunca altura fixa em primitivo.** Tamanho vem de padding e altura de linha.
  Alvo de toque é `BoxConstraints(minHeight: 48)`, não `height: 48`. Todo
  primitivo tem teste em `TextScaler.linear(2.0)`.
- **Cor semântica vem de `NdsTheme.of(context)`, não do `ColorScheme`.** O
  `ColorScheme` do Material não tem papel para `success`, `warning`, `info`, os
  cinco de gráfico nem os da sidebar. Ele continua preenchido para os widgets
  nativos, mas não é a fonte para componente do DS.
- **Nunca citar outro stack no texto do usuário.** Vale aqui como vale na web:
  as docs são consumidas isoladas. "Diferente da web, aqui…" vaza.
- **Botão sem label visível exige `semanticLabel`.** O construtor tem `assert`
  para isso — sem ele o leitor de tela anuncia só "botão".
- **Token em sintaxe CSS é traduzido no gerador**, nunca carregado como `String`
  para o componente resolver. Ver a tabela em `15-paridade-web-flutter.md`.
- **Leia o CSS do componente antes de escrever o Dart.** Nome de token não é
  contrato: `spacing-btn-x`, `-sm` e `-lg` parecem ser o padding lateral do
  botão e valem 10 nas três densidades — o `.nds-button` usa `spacing-4` e
  `spacing-6`. Inferir pelo nome custou quatro erros de layout num componente
  só. A fonte é `.ds-core/` → o CSS em `styles/nds/<slug>.css` do repo web.

## Estado atual

| Pacote | `analyze` | `test` |
|---|---|---|
| `nortear_ds` | limpo | 8 passando |
| `nortear_ds_widgetbook` | limpo | sem testes |

O pipeline de tokens (Node) roda e é idempotente (`npm run tokens:check`).

Versões resolvidas do workbench: widgetbook 3.25.0, annotation 3.11.0,
generator 3.24.0. Os pisos no `pubspec.yaml` são essas versões, não mínimos
otimistas — `knobs.object.dropdown` e `TextScaleAddon(min:, max:)` não existem
antes da 3.25, e afrouxar o piso deixaria a resolução cair numa API que não
compila.

O que **falta verificar**: `flutter run` de fato (o app nunca subiu) e o push
para o Widgetbook Cloud. O workbench não tem testes próprios — os testes vivem
no pacote do design system, que é onde está o comportamento.

### Três armadilhas que já morderam aqui

Ficam registradas porque nenhuma apareceu em revisão.

**`Center` sem `widthFactor`/`heightFactor` engole a tela.** `Align` assume
`constraints.biggest` quando os fatores são nulos. O `NdsButton` media 600dp de
altura — o viewport inteiro. Em botão, use sempre `Center(widthFactor: 1,
heightFactor: 1, …)`, que é o que o `RawMaterialButton` faz.

**Teste de piso não distingue correto de gigante.** Com o botão ocupando a tela,
`minHeight >= 48` e os três `meetsGuideline` de alvo de toque passavam
trivialmente. Quem pegou foi o teste de escala de texto, o único que comparava
duas medidas em vez de checar um limite. Todo primitivo precisa de pelo menos um
teste comparativo, não só de limiar.

**O SDK do Flutter chegou a ser instalado dentro do repo** (`flutter/`, vários GB
e clone git próprio). Já foi movido para `C:\src\flutter`, mas a linha `flutter/`
segue no `.gitignore` de propósito: sem ela, reinstalar ali faz `git add -A`
arrastar o SDK inteiro para o histórico.

Ao mover o SDK, `.dart_tool/package_config.json` de cada pacote guarda o caminho
**absoluto** dele — `flutter pub get` nos dois pacotes é obrigatório depois,
senão `analyze` e `test` procuram o SDK onde ele não está mais.
