import 'package:flutter_test/flutter_test.dart';
import 'package:nortear_ds_widgetbook/main.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// `cloudAddonsConfigs` referencia temas por string dentro de uma anotação, que
/// exige const — não dá para derivar os dois lados de uma fonte só. Sem estes
/// testes, renomear um tema e esquecer a matriz da Cloud não quebra nada: o
/// snapshot simplesmente deixa de ser tirado, e a regressão visual daquela
/// marca some do relatório sem ninguém notar.
void main() {
  final Set<String> declaredThemes =
      NortearWidgetbook.themeSpecs.map((ThemeSpec spec) => spec.name).toSet();

  String themeNameOf(widgetbook.AddonConfig<dynamic> config) =>
      (config.value as String).replaceFirst('name:', '');

  Iterable<widgetbook.AddonConfig<dynamic>> themeConfigs() => cloudAddonsConfigs.values
      .expand((Iterable<widgetbook.AddonConfig<dynamic>> configs) => configs)
      .where((widgetbook.AddonConfig<dynamic> config) => config.key == 'theme');

  test('todo tema citado na matriz da Cloud existe de fato', () {
    for (final widgetbook.AddonConfig<dynamic> config in themeConfigs()) {
      expect(
        declaredThemes,
        contains(themeNameOf(config)),
        reason: 'a matriz da Cloud cita um tema que não está em themeSpecs',
      );
    }
  });

  test('toda marca × brilho tem ao menos um snapshot', () {
    final Set<String> covered = themeConfigs().map(themeNameOf).toSet();
    expect(
      declaredThemes.difference(covered),
      isEmpty,
      reason: 'tema declarado sem snapshot na Cloud — a regressão visual dele '
          'não seria detectada',
    );
  });

  test('nome de tema não pode conter vírgula', () {
    // O valor do AddonConfig é serializado como `chave:valor` separado por
    // vírgula. Uma vírgula no nome partiria a configuração ao meio.
    for (final String name in declaredThemes) {
      expect(name, isNot(contains(',')), reason: 'vírgula quebra a serialização');
    }
  });
}
