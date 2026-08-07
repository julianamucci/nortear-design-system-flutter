// GERADO por tool/generate-tokens.mjs — não editar à mão.
//
// Fonte: @nortear/ds-core · tokens/figma-variables.json · coleção "Movimento"
// Para atualizar: npm run core:sync && npm run tokens:gen

// widgets.dart reexporta foundation (immutable), painting (Color, BoxShadow,
// Offset) e animation (Curve, Cubic, Curves) — um import cobre todo tipo emitido.
import 'package:flutter/widgets.dart';

/// Tokens da coleção "Movimento".
///
/// Modes: default.
@immutable
class NdsMotion {
  const NdsMotion({
    required this.durationInstant,
    required this.durationFast,
    required this.durationBase,
    required this.durationModerate,
    required this.durationPanel,
    required this.durationSpring,
    required this.durationSlow,
    required this.durationStately,
    required this.easeLinear,
    required this.easeStandard,
    required this.easeSize,
    required this.easeSpring,
    required this.easeEmphasis,
    required this.easeEntrance,
    required this.easeExit,
    required this.motionOffsetXs,
    required this.motionOffsetSm,
    required this.motionOffsetMd,
    required this.motionOffsetLg,
  });

  /// `duration-instant`
  final Duration durationInstant;
  /// `duration-fast`
  final Duration durationFast;
  /// `duration-base`
  final Duration durationBase;
  /// `duration-moderate`
  final Duration durationModerate;
  /// `duration-panel`
  final Duration durationPanel;
  /// `duration-spring`
  final Duration durationSpring;
  /// `duration-slow`
  final Duration durationSlow;
  /// `duration-stately`
  final Duration durationStately;
  /// `ease-linear`
  final Curve easeLinear;
  /// `ease-standard`
  final Curve easeStandard;
  /// `ease-size`
  final Curve easeSize;
  /// `ease-spring`
  final Curve easeSpring;
  /// `ease-emphasis`
  final Curve easeEmphasis;
  /// `ease-entrance`
  final Curve easeEntrance;
  /// `ease-exit`
  final Curve easeExit;
  /// `motion-offset-xs`
  final double motionOffsetXs;
  /// `motion-offset-sm`
  final double motionOffsetSm;
  /// `motion-offset-md`
  final double motionOffsetMd;
  /// `motion-offset-lg`
  final double motionOffsetLg;

  /// Mode `default`.
  static const NdsMotion defaultMode = NdsMotion(
    durationInstant: Duration(milliseconds: 0),
    durationFast: Duration(milliseconds: 120),
    durationBase: Duration(milliseconds: 200),
    durationModerate: Duration(milliseconds: 320),
    durationPanel: Duration(milliseconds: 300),
    durationSpring: Duration(milliseconds: 400),
    durationSlow: Duration(milliseconds: 500),
    durationStately: Duration(milliseconds: 800),
    easeLinear: Curves.linear,
    easeStandard: Cubic(0.2, 0.0, 0.0, 1.0),
    easeSize: Cubic(0.25, 0.1, 0.25, 1.0),
    easeSpring: Cubic(0.365, 0.565, 0.121, 1.163),
    easeEmphasis: Cubic(0.3, 0.0, 0.0, 1.0),
    easeEntrance: Cubic(0.0, 0.0, 0.0, 1.0),
    easeExit: Cubic(0.3, 0.0, 1.0, 1.0),
    motionOffsetXs: 4.0,
    motionOffsetSm: 8.0,
    motionOffsetMd: 16.0,
    motionOffsetLg: 32.0,
  );

  /// Mode servido quando nenhum é escolhido.
  static const NdsMotion fallback = defaultMode;

  /// Todos os modes por nome — consumido pelos addons do Widgetbook.
  static const Map<String, NdsMotion> byMode = <String, NdsMotion>{
    'default': defaultMode,
  };
}
