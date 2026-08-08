// GERADO por tool/generate-tokens.mjs — não editar à mão.
//
// Fonte: @nortear/ds-core · tokens/figma-variables.json · coleção "Dimensao"
// Para atualizar: npm run core:sync && npm run tokens:gen

// widgets.dart reexporta foundation (immutable), painting (Color, BoxShadow,
// Offset) e animation (Curve, Cubic, Curves) — um import cobre todo tipo emitido.
import 'package:flutter/widgets.dart';

/// Tokens da coleção "Dimensao".
///
/// Modes: default, condensado, confortavel.
@immutable
class NdsDimensions {
  const NdsDimensions({
    required this.spacingBase,
    required this.spacing0,
    required this.spacingPx,
    required this.spacing05,
    required this.spacing1,
    required this.spacing2,
    required this.spacing4,
    required this.spacing6,
    required this.spacing8,
    required this.spacing10,
    required this.spacing12,
    required this.spacing14,
    required this.spacing16,
    required this.spacing20,
    required this.spacing24,
    required this.heightSm,
    required this.heightDefault,
    required this.sizeXs,
    required this.sizeSm,
    required this.sizeDefault,
    required this.sizeLg,
    required this.sizeXl,
    required this.borderWidthDefault,
  });

  /// `spacing-base`
  final double spacingBase;
  /// `spacing-0`
  final double spacing0;
  /// `spacing-px`
  final double spacingPx;
  /// `spacing-0-5`
  final double spacing05;
  /// `spacing-1`
  final double spacing1;
  /// `spacing-2`
  final double spacing2;
  /// `spacing-4`
  final double spacing4;
  /// `spacing-6`
  final double spacing6;
  /// `spacing-8`
  final double spacing8;
  /// `spacing-10`
  final double spacing10;
  /// `spacing-12`
  final double spacing12;
  /// `spacing-14`
  final double spacing14;
  /// `spacing-16`
  final double spacing16;
  /// `spacing-20`
  final double spacing20;
  /// `spacing-24`
  final double spacing24;
  /// `height-sm`
  final double heightSm;
  /// `height-default`
  final double heightDefault;
  /// `size-xs`
  final double sizeXs;
  /// `size-sm`
  final double sizeSm;
  /// `size-default`
  final double sizeDefault;
  /// `size-lg`
  final double sizeLg;
  /// `size-xl`
  final double sizeXl;
  /// `border-width-default`
  final double borderWidthDefault;

  /// Mode `default`.
  static const NdsDimensions defaultMode = NdsDimensions(
    spacingBase: 4.0,
    spacing0: 0.0,
    spacingPx: 1.0,
    spacing05: 2.0,
    spacing1: 4.0,
    spacing2: 8.0,
    spacing4: 16.0,
    spacing6: 24.0,
    spacing8: 32.0,
    spacing10: 40.0,
    spacing12: 48.0,
    spacing14: 56.0,
    spacing16: 64.0,
    spacing20: 80.0,
    spacing24: 96.0,
    heightSm: 28.0,
    heightDefault: 32.0,
    sizeXs: 24.0,
    sizeSm: 28.0,
    sizeDefault: 32.0,
    sizeLg: 36.0,
    sizeXl: 40.0,
    borderWidthDefault: 1.0,
  );

  /// Mode `condensado`.
  static const NdsDimensions condensado = NdsDimensions(
    spacingBase: 3.2,
    spacing0: 0.0,
    spacingPx: 1.0,
    spacing05: 1.6,
    spacing1: 3.2,
    spacing2: 6.4,
    spacing4: 12.8,
    spacing6: 19.2,
    spacing8: 25.6,
    spacing10: 32.0,
    spacing12: 38.4,
    spacing14: 44.8,
    spacing16: 51.2,
    spacing20: 64.0,
    spacing24: 76.8,
    heightSm: 24.0,
    heightDefault: 28.0,
    sizeXs: 20.0,
    sizeSm: 24.0,
    sizeDefault: 28.0,
    sizeLg: 32.0,
    sizeXl: 36.0,
    borderWidthDefault: 1.0,
  );

  /// Mode `confortavel`.
  static const NdsDimensions confortavel = NdsDimensions(
    spacingBase: 5.0,
    spacing0: 0.0,
    spacingPx: 1.0,
    spacing05: 2.5,
    spacing1: 5.0,
    spacing2: 10.0,
    spacing4: 20.0,
    spacing6: 30.0,
    spacing8: 40.0,
    spacing10: 50.0,
    spacing12: 60.0,
    spacing14: 70.0,
    spacing16: 80.0,
    spacing20: 100.0,
    spacing24: 120.0,
    heightSm: 32.0,
    heightDefault: 40.0,
    sizeXs: 28.0,
    sizeSm: 32.0,
    sizeDefault: 40.0,
    sizeLg: 44.0,
    sizeXl: 48.0,
    borderWidthDefault: 1.0,
  );

  /// Mode servido quando nenhum é escolhido.
  static const NdsDimensions fallback = defaultMode;

  /// Todos os modes por nome — consumido pelos addons do Widgetbook.
  static const Map<String, NdsDimensions> byMode = <String, NdsDimensions>{
    'default': defaultMode,
    'condensado': condensado,
    'confortavel': confortavel,
  };
}
