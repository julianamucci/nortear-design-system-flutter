import 'package:flutter/material.dart';
import 'package:nortear_ds/nortear_ds.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// GERADO por build_runner a partir das anotações @widgetbook.UseCase.
// Rode `dart run build_runner build` antes do primeiro `flutter run`.
import 'main.directories.g.dart';

void main() => runApp(const NortearWidgetbook());

@widgetbook.App()
class NortearWidgetbook extends StatelessWidget {
  const NortearWidgetbook({super.key});

  /// As 6 combinações de tema do sistema: 3 marcas × claro/escuro.
  ///
  /// Marca e brilho ficam num addon só de propósito. Não são eixos
  /// independentes — o tema é a escolha, e `warm-dark` é um conjunto de tokens
  /// tanto quanto `default-light`. Separá-los em dois seletores deixaria
  /// combinar coisas que a coleção `Cor` não define.
  static List<WidgetbookTheme<ThemeData>> get _themes {
    return <WidgetbookTheme<ThemeData>>[
      for (final String brand in NortearTheme.brands)
        for (final Brightness brightness in Brightness.values)
          WidgetbookTheme<ThemeData>(
            name: '$brand · ${brightness == Brightness.light ? 'claro' : 'escuro'}',
            data: NortearTheme.data(brand: brand, brightness: brightness),
          ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: <WidgetbookAddon<dynamic>>[
        ThemeAddon<ThemeData>(
          themes: _themes,
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
