// GERADO por tool/generate-tokens.mjs — não editar à mão.
//
// Fonte: @nortear/ds-core · tokens/figma-variables.json · coleção "Elevacao"
// Para atualizar: npm run core:sync && npm run tokens:gen

// widgets.dart reexporta foundation (immutable), painting (Color, BoxShadow,
// Offset) e animation (Curve, Cubic, Curves) — um import cobre todo tipo emitido.
import 'package:flutter/widgets.dart';

/// Tokens da coleção "Elevacao".
///
/// Modes: light, dark.
@immutable
class NdsElevation {
  const NdsElevation({
    required this.elevationSm,
    required this.elevationMd,
    required this.elevationLg,
    required this.elevationXl,
  });

  /// `elevation-sm`
  final List<BoxShadow> elevationSm;
  /// `elevation-md`
  final List<BoxShadow> elevationMd;
  /// `elevation-lg`
  final List<BoxShadow> elevationLg;
  /// `elevation-xl`
  final List<BoxShadow> elevationXl;

  /// Mode `light`.
  static const NdsElevation light = NdsElevation(
    elevationSm: <BoxShadow>[BoxShadow(color: Color(0x1A000000), offset: Offset(0.0, 1.0), blurRadius: 2.0, spreadRadius: 0.0)],
    elevationMd: <BoxShadow>[BoxShadow(color: Color(0x1A000000), offset: Offset(0.0, 4.0), blurRadius: 6.0, spreadRadius: -1.0), BoxShadow(color: Color(0x0F000000), offset: Offset(0.0, 2.0), blurRadius: 4.0, spreadRadius: -1.0)],
    elevationLg: <BoxShadow>[BoxShadow(color: Color(0x1A000000), offset: Offset(0.0, 10.0), blurRadius: 15.0, spreadRadius: -3.0), BoxShadow(color: Color(0x0D000000), offset: Offset(0.0, 4.0), blurRadius: 6.0, spreadRadius: -2.0)],
    elevationXl: <BoxShadow>[BoxShadow(color: Color(0x1A000000), offset: Offset(0.0, 20.0), blurRadius: 25.0, spreadRadius: -5.0), BoxShadow(color: Color(0x0A000000), offset: Offset(0.0, 10.0), blurRadius: 10.0, spreadRadius: -5.0)],
  );

  /// Mode `dark`.
  static const NdsElevation dark = NdsElevation(
    elevationSm: <BoxShadow>[BoxShadow(color: Color(0x4D000000), offset: Offset(0.0, 1.0), blurRadius: 2.0, spreadRadius: 0.0)],
    elevationMd: <BoxShadow>[BoxShadow(color: Color(0x4D000000), offset: Offset(0.0, 4.0), blurRadius: 6.0, spreadRadius: -1.0), BoxShadow(color: Color(0x33000000), offset: Offset(0.0, 2.0), blurRadius: 4.0, spreadRadius: -1.0)],
    elevationLg: <BoxShadow>[BoxShadow(color: Color(0x4D000000), offset: Offset(0.0, 10.0), blurRadius: 15.0, spreadRadius: -3.0), BoxShadow(color: Color(0x33000000), offset: Offset(0.0, 4.0), blurRadius: 6.0, spreadRadius: -2.0)],
    elevationXl: <BoxShadow>[BoxShadow(color: Color(0x4D000000), offset: Offset(0.0, 20.0), blurRadius: 25.0, spreadRadius: -5.0), BoxShadow(color: Color(0x1A000000), offset: Offset(0.0, 10.0), blurRadius: 10.0, spreadRadius: -5.0)],
  );

  /// Mode servido quando nenhum é escolhido.
  static const NdsElevation fallback = light;

  /// Todos os modes por nome — consumido pelos addons do Widgetbook.
  static const Map<String, NdsElevation> byMode = <String, NdsElevation>{
    'light': light,
    'dark': dark,
  };
}
