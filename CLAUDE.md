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
dart run build_runner build -d    # gera main.directories.g.dart
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

## Estado atual

Este repo foi criado **sem SDK do Flutter na máquina**. Consequência direta:

- O pipeline de tokens (Node) foi executado e verificado de verdade.
- **Nenhum arquivo Dart foi compilado, analisado ou testado.**
- `main.directories.g.dart` não existe — o `build_runner` não rodou. O app do
  Widgetbook não sobe até `dart run build_runner build -d` ser executado.
- As restrições de versão em `pubspec.yaml` não passaram por `flutter pub get`.

O primeiro passo de quem tiver o SDK é: `flutter pub get`, `flutter analyze`,
`flutter test`, `build_runner`. Espere ajustes.
