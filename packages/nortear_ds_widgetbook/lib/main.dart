import 'package:flutter/material.dart';
import 'package:nortear_ds/nortear_ds.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// GERADO por build_runner a partir das anotações @widgetbook.UseCase.
// Rode `dart run build_runner build -d` antes do primeiro `flutter run`.
import 'main.directories.g.dart';

void main() => runApp(const NortearWidgetbook());

@widgetbook.App()
class NortearWidgetbook extends StatelessWidget {
  const NortearWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: <WidgetbookAddon<dynamic>>[
        // Os quatro primeiros existem porque o sistema tem esses eixos: 3 marcas
        // × claro/escuro, 3 densidades e 8 escalas tipográficas. Sem eles, o
        // workbench mostraria um recorte e esconderia o resto.
        WidgetbookAddon<ThemeData>.dropdown(
          name: 'Marca',
          initialSetting: 'default',
          values: NortearTheme.brands,
          buildSetting: (String brand) => NortearTheme.data(brand: brand),
          builder: (BuildContext context, ThemeData theme, Widget? child) =>
              Theme(data: theme, child: child ?? const SizedBox.shrink()),
        ),
        ThemeAddon<ThemeData>(
          themes: <WidgetbookTheme<ThemeData>>[
            WidgetbookTheme<ThemeData>(name: 'Claro', data: NortearTheme.data()),
            WidgetbookTheme<ThemeData>(
              name: 'Escuro',
              data: NortearTheme.data(brightness: Brightness.dark),
            ),
          ],
          themeBuilder: (BuildContext context, ThemeData theme, Widget child) =>
              Theme(data: theme, child: child),
        ),
        // O TextScale não é conforto: é o teste vivo da regra de nunca usar
        // altura fixa em primitivo. Em 2.0, botão com `height` corta o texto.
        // É a leitura Flutter do WCAG 1.4.4.
        TextScaleAddon(scales: <double>[1.0, 1.3, 2.0]),
        AlignmentAddon(),
        ViewportAddon(<ViewportData>[
          Viewports.none,
          IosViewports.phones.iPhone13,
          AndroidViewports.phones.samsungGalaxyS20,
          MacosViewports.macbookPro,
        ]),
      ],
    );
  }
}
