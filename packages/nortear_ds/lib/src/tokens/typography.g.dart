// GERADO por tool/generate-tokens.mjs — não editar à mão.
//
// Fonte: @nortear/ds-core · tokens/figma-variables.json · coleção "Tipografia"
// Para atualizar: npm run core:sync && npm run tokens:gen

// widgets.dart reexporta foundation (immutable), painting (Color, BoxShadow,
// Offset) e animation (Curve, Cubic, Curves) — um import cobre todo tipo emitido.
import 'package:flutter/widgets.dart';

/// Tokens da coleção "Tipografia".
///
/// Modes: minor-second, minor-third, major-second, major-third, perfect-fourth, augmented-fourth, perfect-fifth, golden.
@immutable
class NdsTypography {
  const NdsTypography({
    required this.textLabel,
    required this.textP,
    required this.textH4,
    required this.textH3,
    required this.textH2,
    required this.textH1,
    required this.typeBase,
    required this.typeScale,
    required this.fontWeightExtraBold,
    required this.fontWeightSemiBold,
    required this.fontWeightMedium,
    required this.fontWeightRegular,
    required this.lineHeightTight,
    required this.lineHeightNormal,
    required this.lineHeightRelaxed,
    required this.lineHeightLoose,
    required this.letterSpacingTightEm,
    required this.letterSpacingNormalEm,
    required this.letterSpacingWideEm,
  });

  /// `text-label`
  final double textLabel;
  /// `text-p`
  final double textP;
  /// `text-h4`
  final double textH4;
  /// `text-h3`
  final double textH3;
  /// `text-h2`
  final double textH2;
  /// `text-h1`
  final double textH1;
  /// `type-base`
  final double typeBase;
  /// `type-scale`
  final double typeScale;
  /// `font-weight-extra-bold`
  final double fontWeightExtraBold;
  /// `font-weight-semi-bold`
  final double fontWeightSemiBold;
  /// `font-weight-medium`
  final double fontWeightMedium;
  /// `font-weight-regular`
  final double fontWeightRegular;
  /// `line-height-tight`
  final double lineHeightTight;
  /// `line-height-normal`
  final double lineHeightNormal;
  /// `line-height-relaxed`
  final double lineHeightRelaxed;
  /// `line-height-loose`
  final double lineHeightLoose;
  /// `letter-spacing-tight`
  final double letterSpacingTightEm;
  /// `letter-spacing-normal`
  final double letterSpacingNormalEm;
  /// `letter-spacing-wide`
  final double letterSpacingWideEm;

  /// Mode `minor-second`.
  static const NdsTypography minorSecond = NdsTypography(
    textLabel: 14.995,
    textP: 16.0,
    textH4: 17.072,
    textH3: 18.216,
    textH2: 19.436,
    textH1: 20.739,
    typeBase: 16.0,
    typeScale: 1.067,
    fontWeightExtraBold: 800.0,
    fontWeightSemiBold: 600.0,
    fontWeightMedium: 500.0,
    fontWeightRegular: 400.0,
    lineHeightTight: 1.2,
    lineHeightNormal: 1.5,
    lineHeightRelaxed: 1.75,
    lineHeightLoose: 2.0,
    letterSpacingTightEm: -0.02,
    letterSpacingNormalEm: 0.0,
    letterSpacingWideEm: 0.02,
  );

  /// Mode `minor-third`.
  static const NdsTypography minorThird = NdsTypography(
    textLabel: 13.333,
    textP: 16.0,
    textH4: 19.2,
    textH3: 23.04,
    textH2: 27.648,
    textH1: 33.178,
    typeBase: 16.0,
    typeScale: 1.2,
    fontWeightExtraBold: 800.0,
    fontWeightSemiBold: 600.0,
    fontWeightMedium: 500.0,
    fontWeightRegular: 400.0,
    lineHeightTight: 1.2,
    lineHeightNormal: 1.5,
    lineHeightRelaxed: 1.75,
    lineHeightLoose: 2.0,
    letterSpacingTightEm: -0.02,
    letterSpacingNormalEm: 0.0,
    letterSpacingWideEm: 0.02,
  );

  /// Mode `major-second`.
  static const NdsTypography majorSecond = NdsTypography(
    textLabel: 14.222,
    textP: 16.0,
    textH4: 18.0,
    textH3: 20.25,
    textH2: 22.781,
    textH1: 25.629,
    typeBase: 16.0,
    typeScale: 1.125,
    fontWeightExtraBold: 800.0,
    fontWeightSemiBold: 600.0,
    fontWeightMedium: 500.0,
    fontWeightRegular: 400.0,
    lineHeightTight: 1.2,
    lineHeightNormal: 1.5,
    lineHeightRelaxed: 1.75,
    lineHeightLoose: 2.0,
    letterSpacingTightEm: -0.02,
    letterSpacingNormalEm: 0.0,
    letterSpacingWideEm: 0.02,
  );

  /// Mode `major-third`.
  static const NdsTypography majorThird = NdsTypography(
    textLabel: 12.8,
    textP: 16.0,
    textH4: 20.0,
    textH3: 25.0,
    textH2: 31.25,
    textH1: 39.063,
    typeBase: 16.0,
    typeScale: 1.25,
    fontWeightExtraBold: 800.0,
    fontWeightSemiBold: 600.0,
    fontWeightMedium: 500.0,
    fontWeightRegular: 400.0,
    lineHeightTight: 1.2,
    lineHeightNormal: 1.5,
    lineHeightRelaxed: 1.75,
    lineHeightLoose: 2.0,
    letterSpacingTightEm: -0.02,
    letterSpacingNormalEm: 0.0,
    letterSpacingWideEm: 0.02,
  );

  /// Mode `perfect-fourth`.
  static const NdsTypography perfectFourth = NdsTypography(
    textLabel: 12.003,
    textP: 16.0,
    textH4: 21.328,
    textH3: 28.43,
    textH2: 37.897,
    textH1: 50.517,
    typeBase: 16.0,
    typeScale: 1.333,
    fontWeightExtraBold: 800.0,
    fontWeightSemiBold: 600.0,
    fontWeightMedium: 500.0,
    fontWeightRegular: 400.0,
    lineHeightTight: 1.2,
    lineHeightNormal: 1.5,
    lineHeightRelaxed: 1.75,
    lineHeightLoose: 2.0,
    letterSpacingTightEm: -0.02,
    letterSpacingNormalEm: 0.0,
    letterSpacingWideEm: 0.02,
  );

  /// Mode `augmented-fourth`.
  static const NdsTypography augmentedFourth = NdsTypography(
    textLabel: 11.315,
    textP: 16.0,
    textH4: 22.624,
    textH3: 31.99,
    textH2: 45.234,
    textH1: 63.961,
    typeBase: 16.0,
    typeScale: 1.414,
    fontWeightExtraBold: 800.0,
    fontWeightSemiBold: 600.0,
    fontWeightMedium: 500.0,
    fontWeightRegular: 400.0,
    lineHeightTight: 1.2,
    lineHeightNormal: 1.5,
    lineHeightRelaxed: 1.75,
    lineHeightLoose: 2.0,
    letterSpacingTightEm: -0.02,
    letterSpacingNormalEm: 0.0,
    letterSpacingWideEm: 0.02,
  );

  /// Mode `perfect-fifth`.
  static const NdsTypography perfectFifth = NdsTypography(
    textLabel: 10.667,
    textP: 16.0,
    textH4: 24.0,
    textH3: 36.0,
    textH2: 54.0,
    textH1: 81.0,
    typeBase: 16.0,
    typeScale: 1.5,
    fontWeightExtraBold: 800.0,
    fontWeightSemiBold: 600.0,
    fontWeightMedium: 500.0,
    fontWeightRegular: 400.0,
    lineHeightTight: 1.2,
    lineHeightNormal: 1.5,
    lineHeightRelaxed: 1.75,
    lineHeightLoose: 2.0,
    letterSpacingTightEm: -0.02,
    letterSpacingNormalEm: 0.0,
    letterSpacingWideEm: 0.02,
  );

  /// Mode `golden`.
  static const NdsTypography golden = NdsTypography(
    textLabel: 9.889,
    textP: 16.0,
    textH4: 25.888,
    textH3: 41.887,
    textH2: 67.773,
    textH1: 109.656,
    typeBase: 16.0,
    typeScale: 1.618,
    fontWeightExtraBold: 800.0,
    fontWeightSemiBold: 600.0,
    fontWeightMedium: 500.0,
    fontWeightRegular: 400.0,
    lineHeightTight: 1.2,
    lineHeightNormal: 1.5,
    lineHeightRelaxed: 1.75,
    lineHeightLoose: 2.0,
    letterSpacingTightEm: -0.02,
    letterSpacingNormalEm: 0.0,
    letterSpacingWideEm: 0.02,
  );

  /// Mode servido quando nenhum é escolhido.
  static const NdsTypography fallback = minorThird;

  /// Todos os modes por nome — consumido pelos addons do Widgetbook.
  static const Map<String, NdsTypography> byMode = <String, NdsTypography>{
    'minor-second': minorSecond,
    'minor-third': minorThird,
    'major-second': majorSecond,
    'major-third': majorThird,
    'perfect-fourth': perfectFourth,
    'augmented-fourth': augmentedFourth,
    'perfect-fifth': perfectFifth,
    'golden': golden,
  };
}
