// GERADO por tool/generate-tokens.mjs — não editar à mão.
//
// Fonte: @nortear/ds-core · tokens/figma-variables.json · coleção "Fonte"
// Para atualizar: npm run core:sync && npm run tokens:gen

// widgets.dart reexporta foundation (immutable), painting (Color, BoxShadow,
// Offset) e animation (Curve, Cubic, Curves) — um import cobre todo tipo emitido.
import 'package:flutter/widgets.dart';

/// Tokens da coleção "Fonte".
///
/// Modes: default, lexend, pt-serif, lxgw-wenkai.
@immutable
class NdsFonts {
  const NdsFonts({
    required this.fontFamilyActive,
  });

  /// `font-family-active`
  final String fontFamilyActive;

  /// Mode `default`.
  static const NdsFonts defaultMode = NdsFonts(
    fontFamilyActive: 'Inter',
  );

  /// Mode `lexend`.
  static const NdsFonts lexend = NdsFonts(
    fontFamilyActive: 'Lexend',
  );

  /// Mode `pt-serif`.
  static const NdsFonts ptSerif = NdsFonts(
    fontFamilyActive: 'PT Serif',
  );

  /// Mode `lxgw-wenkai`.
  static const NdsFonts lxgwWenkai = NdsFonts(
    fontFamilyActive: 'LXGW WenKai TC',
  );

  /// Mode servido quando nenhum é escolhido.
  static const NdsFonts fallback = defaultMode;

  /// Todos os modes por nome — consumido pelos addons do Widgetbook.
  static const Map<String, NdsFonts> byMode = <String, NdsFonts>{
    'default': defaultMode,
    'lexend': lexend,
    'pt-serif': ptSerif,
    'lxgw-wenkai': lxgwWenkai,
  };
}
