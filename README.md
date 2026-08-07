# Nortear Design System — Flutter

Implementação Flutter do Nortear DS. Compartilha tokens, conteúdo trilíngue e
guidelines com o monorepo web pelo pacote `@nortear/ds-core`; os componentes são
escritos para o modelo de interação nativo.

O workbench é o [Widgetbook](https://widgetbook.io) — o papel que o Storybook
tem na web. Regressão visual e review por PR ficam no Widgetbook Cloud.

## Começando

```bash
npm run core:sync      # traz tokens e conteúdo do ds-core
npm run tokens:gen     # gera o Dart dos tokens

cd packages/nortear_ds && flutter pub get && flutter test

cd ../nortear_ds_widgetbook
flutter pub get
dart run build_runner build -d
flutter run -d chrome
```

Por padrão o `core:sync` procura o monorepo web em `../design-system`. Para
consumir uma versão fixada:

```bash
npm run core:sync -- --from ../design-system/nortear-ds-core-1.0.0.tgz
```

## Como os tokens chegam aqui

```
tokens.css (repo web, fonte de verdade)
  └─ build-figma-variables.mjs  →  figma-variables.json   (hex resolvido, por mode)
       └─ @nortear/ds-core                                (pacote versionado)
            └─ tool/generate-tokens.mjs  →  lib/src/tokens/*.g.dart   (COMMITADO)
```

O Dart é **commitado**: `flutter pub get` não depende de Node e o clone é
reproduzível. `npm run tokens:check` no CI falha se o commitado divergir da
fonte, então ninguém edita o gerado à mão sem ser pego.

A fonte é o `figma-variables.json`, não os `.css`. O CSS carrega `calc()`,
`hsl(var(--x))` e cascade — resolver isso fora do navegador é reimplementar um
motor de estilo. O JSON já é o resultado resolvido.

Nem tudo atravessa igual: `cubic-bezier` vira `Cubic`, ms vira `Duration`,
`box-shadow` vira `List<BoxShadow>`, e z-index não vira nada. A tabela completa
está em [docs/guidelines/15-paridade-web-flutter.md](docs/guidelines/15-paridade-web-flutter.md).

## Estado

Primeiro corte. Tem: pipeline de tokens (6 coleções, 51 cores × 6 modes), camada
de tema, `NdsButton` com testes de comportamento e acessibilidade, e o app do
Widgetbook com cinco addons.

**Nenhum Dart foi compilado** — o repositório foi criado numa máquina sem SDK do
Flutter. Detalhes e primeiros passos em [CLAUDE.md](CLAUDE.md).
