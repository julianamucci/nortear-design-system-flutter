import 'package:flutter/material.dart';
import 'package:nortear_ds/nortear_ds.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Playground — todo eixo do botão exposto como knob.
///
/// Equivale ao que a story `Playground` faz nos stacks web: um único caso onde
/// o usuário combina variante, tamanho e estado, em vez de N casos fixos.
@widgetbook.UseCase(name: 'Playground', type: NdsButton)
Widget buildNdsButtonPlayground(BuildContext context) {
  return Center(
    child: NdsButton(
      label: context.knobs.string(label: 'Label', initialValue: 'Salvar'),
      variant: context.knobs.list<NdsButtonVariant>(
        label: 'Variante',
        options: NdsButtonVariant.values,
        labelBuilder: (NdsButtonVariant v) => v.name,
      ),
      size: context.knobs.list<NdsButtonSize>(
        label: 'Tamanho',
        options: NdsButtonSize.values,
        labelBuilder: (NdsButtonSize s) => s.name,
      ),
      loading: context.knobs.boolean(label: 'Carregando'),
      onPressed: context.knobs.boolean(label: 'Habilitado', initialValue: true) ? () {} : null,
    ),
  );
}

/// Todas as variantes lado a lado — o caso que o Widgetbook Cloud compara entre
/// commits. Um diff visual aqui pega regressão de token sem ninguém abrir o app.
@widgetbook.UseCase(name: 'Variantes', type: NdsButton)
Widget buildNdsButtonVariants(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: NdsButtonVariant.values
          .map((NdsButtonVariant v) => NdsButton(label: v.name, variant: v, onPressed: () {}))
          .toList(),
    ),
  );
}

/// Estados que não dependem de interação do usuário.
@widgetbook.UseCase(name: 'Estados', type: NdsButton)
Widget buildNdsButtonStates(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: <Widget>[
        NdsButton(label: 'Padrão', onPressed: () {}),
        const NdsButton(label: 'Desabilitado', onPressed: null),
        NdsButton(label: 'Carregando', loading: true, onPressed: () {}),
        NdsButton(
          icon: Icons.add,
          size: NdsButtonSize.icon,
          semanticLabel: 'Adicionar item',
          onPressed: () {},
        ),
      ],
    ),
  );
}
