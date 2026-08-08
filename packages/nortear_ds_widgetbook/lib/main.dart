import 'package:flutter/material.dart';
import 'package:nortear_ds/nortear_ds.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// GERADO por build_runner a partir das anotações @widgetbook.UseCase.
// Rode `dart run build_runner build` antes do primeiro `flutter run`.
import 'main.directories.g.dart';

void main() => runApp(const NortearWidgetbook());

/// Um tema do workbench: nome exibido + como montá-lo.
///
/// O nome precisa ser literal e estável porque `cloudAddonsConfigs` o referencia
/// por string, e anotação exige const — não dá para gerar os dois de uma função
/// só. `themeNamesTest` existe para que renomear aqui e esquecer lá falhe no
/// teste em vez de sumir silenciosamente do relatório da Cloud.
@immutable
class ThemeSpec {
  const ThemeSpec(this.name, this.brand, this.brightness);
  final String name;
  final String brand;
  final Brightness brightness;
}

/// Matriz de snapshots enviada à Widgetbook Cloud.
///
/// Cada entrada vira um snapshot por use case. São 8 configurações × 3 use
/// cases = 24 snapshots por build, e a escolha não é arbitrária:
///
/// - As 6 combinações de marca × brilho em escala 1.0 pegam regressão de token.
///   Sem elas, um erro que só aparece em `warm-dark` passa invisível, que é
///   exatamente o risco de um sistema multi-marca.
/// - Escala 2.0 só nas duas do tema padrão. O que a escala de texto quebra é
///   layout, não paleta — repetir nas 6 marcas multiplicaria custo sem cobrir
///   nada novo.
const widgetbook.AddonsConfigs cloudAddonsConfigs = <String, List<widgetbook.AddonConfig<dynamic>>>{
  'default claro': <widgetbook.AddonConfig<dynamic>>[widgetbook.ThemeAddonConfig('default claro')],
  'default escuro': <widgetbook.AddonConfig<dynamic>>[widgetbook.ThemeAddonConfig('default escuro')],
  'warm claro': <widgetbook.AddonConfig<dynamic>>[widgetbook.ThemeAddonConfig('warm claro')],
  'warm escuro': <widgetbook.AddonConfig<dynamic>>[widgetbook.ThemeAddonConfig('warm escuro')],
  'cold claro': <widgetbook.AddonConfig<dynamic>>[widgetbook.ThemeAddonConfig('cold claro')],
  'cold escuro': <widgetbook.AddonConfig<dynamic>>[widgetbook.ThemeAddonConfig('cold escuro')],
  'default claro · texto 2x': <widgetbook.AddonConfig<dynamic>>[
    widgetbook.ThemeAddonConfig('default claro'),
    widgetbook.TextScaleAddonConfig(2),
  ],
  'default escuro · texto 2x': <widgetbook.AddonConfig<dynamic>>[
    widgetbook.ThemeAddonConfig('default escuro'),
    widgetbook.TextScaleAddonConfig(2),
  ],
};

@widgetbook.App(cloudAddonsConfigs: cloudAddonsConfigs)
class NortearWidgetbook extends StatelessWidget {
  const NortearWidgetbook({super.key});

  /// As 6 combinações de tema do sistema: 3 marcas × claro/escuro.
  ///
  /// Marca e brilho ficam num addon só de propósito. Não são eixos
  /// independentes — o tema é a escolha, e `warm escuro` é um conjunto de
  /// tokens tanto quanto `default claro`. Separá-los em dois seletores deixaria
  /// combinar coisas que a coleção `Cor` não define.
  static const List<ThemeSpec> themeSpecs = <ThemeSpec>[
    ThemeSpec('default claro', 'default', Brightness.light),
    ThemeSpec('default escuro', 'default', Brightness.dark),
    ThemeSpec('warm claro', 'warm', Brightness.light),
    ThemeSpec('warm escuro', 'warm', Brightness.dark),
    ThemeSpec('cold claro', 'cold', Brightness.light),
    ThemeSpec('cold escuro', 'cold', Brightness.dark),
  ];

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: <WidgetbookAddon<dynamic>>[
        ThemeAddon<ThemeData>(
          themes: themeSpecs
              .map(
                (ThemeSpec spec) => WidgetbookTheme<ThemeData>(
                  name: spec.name,
                  data: NortearTheme.data(brand: spec.brand, brightness: spec.brightness),
                ),
              )
              .toList(),
          themeBuilder: (BuildContext context, ThemeData theme, Widget child) =>
              Theme(data: theme, child: child),
        ),
        // Não é conforto: é o teste vivo da regra de nunca usar altura fixa em
        // primitivo. Em 2.0, botão com `height` corta o texto. É a leitura
        // Flutter do WCAG 1.4.4. O piso é 1.0 porque abaixo disso não há
        // critério a verificar.
        TextScaleAddon(min: 1, max: 2),
        AlignmentAddon(),
        ViewportAddon(<ViewportData>[
          Viewports.none,
          IosViewports.iPhone13,
          AndroidViewports.samsungGalaxyS20,
          MacosViewports.macbookPro,
        ]),
      ],
    );
  }
}
