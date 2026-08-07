import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nortear_ds/nortear_ds.dart';

/// Envolve o widget no tema do sistema — sem isso `NdsTheme.of` dispara assert.
Widget _wrap(Widget child, {double textScale = 1.0, Brightness brightness = Brightness.light}) {
  return MaterialApp(
    theme: NortearTheme.data(brightness: brightness),
    home: MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
      child: Scaffold(body: Center(child: child)),
    ),
  );
}

void main() {
  group('NdsButton — comportamento', () {
    testWidgets('dispara onPressed no toque', (WidgetTester tester) async {
      int taps = 0;
      await tester.pumpWidget(_wrap(NdsButton(label: 'Salvar', onPressed: () => taps++)));

      await tester.tap(find.text('Salvar'));
      expect(taps, 1);
    });

    testWidgets('onPressed nulo não dispara', (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(const NdsButton(label: 'Salvar', onPressed: null)));

      await tester.tap(find.text('Salvar'));
      // Sem callback não há o que contar; o teste garante que tocar não lança.
      expect(tester.takeException(), isNull);
    });

    testWidgets('carregando não dispara e mostra progresso', (WidgetTester tester) async {
      int taps = 0;
      await tester.pumpWidget(_wrap(NdsButton(label: 'Salvar', loading: true, onPressed: () => taps++)));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(NdsButton));
      expect(taps, 0, reason: 'botão carregando aceitou toque');
    });
  });

  group('NdsButton — acessibilidade', () {
    testWidgets('alvo de toque mínimo de 48dp', (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(NdsButton(label: 'Ok', onPressed: () {})));

      final Size size = tester.getSize(find.byType(NdsButton));
      expect(size.height, greaterThanOrEqualTo(48));
      expect(size.width, greaterThanOrEqualTo(48));
    });

    testWidgets('cresce com a fonte em vez de cortar o texto', (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(NdsButton(label: 'Salvar', onPressed: () {})));
      final double base = tester.getSize(find.byType(NdsButton)).height;

      await tester.pumpWidget(_wrap(NdsButton(label: 'Salvar', onPressed: () {}), textScale: 2.0));
      final double scaled = tester.getSize(find.byType(NdsButton)).height;

      expect(
        scaled,
        greaterThan(base),
        reason: 'altura não acompanhou a fonte — sinal de height fixo (WCAG 1.4.4)',
      );
      expect(tester.takeException(), isNull, reason: 'overflow em textScale 2.0');
    });

    testWidgets('botão só de ícone é anunciado pelo semanticLabel', (WidgetTester tester) async {
      await tester.pumpWidget(
        _wrap(NdsButton(
          icon: Icons.add,
          size: NdsButtonSize.icon,
          semanticLabel: 'Adicionar item',
          onPressed: () {},
        )),
      );

      expect(find.bySemanticsLabel('Adicionar item'), findsOneWidget);
    });

    testWidgets('atende os guidelines de toque e rótulo do flutter_test', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_wrap(NdsButton(label: 'Salvar', onPressed: () {})));

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      handle.dispose();
    });
  });

  group('Tokens', () {
    test('todo mode de cor existe nas 3 marcas × claro/escuro', () {
      for (final String brand in NortearTheme.brands) {
        for (final String bright in <String>['light', 'dark']) {
          expect(
            NdsColors.byMode['$brand-$bright'],
            isNotNull,
            reason: 'falta o mode de cor $brand-$bright',
          );
        }
      }
    });
  });
}
