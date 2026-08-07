// GERADO por tool/generate-tokens.mjs — não editar à mão.
//
// Fonte: @nortear/ds-core · tokens/figma-variables.json · coleção "Raio"
// Para atualizar: npm run core:sync && npm run tokens:gen

// widgets.dart reexporta foundation (immutable), painting (Color, BoxShadow,
// Offset) e animation (Curve, Cubic, Curves) — um import cobre todo tipo emitido.
import 'package:flutter/widgets.dart';

/// Tokens da coleção "Raio".
///
/// Modes: default.
@immutable
class NdsRadii {
  const NdsRadii({
    required this.radius,
    required this.radiusNone,
    required this.radiusXs,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusXl,
    required this.radiusFull,
    required this.radiusButton,
    required this.radiusInput,
    required this.radiusAlert,
    required this.radiusCard,
    required this.radiusBadge,
  });

  /// `radius`
  final double radius;
  /// `radius-none`
  final double radiusNone;
  /// `radius-xs`
  final double radiusXs;
  /// `radius-sm`
  final double radiusSm;
  /// `radius-md`
  final double radiusMd;
  /// `radius-lg`
  final double radiusLg;
  /// `radius-xl`
  final double radiusXl;
  /// `radius-full`
  final double radiusFull;
  /// `radius-button`
  final double radiusButton;
  /// `radius-input`
  final double radiusInput;
  /// `radius-alert`
  final double radiusAlert;
  /// `radius-card`
  final double radiusCard;
  /// `radius-badge`
  final double radiusBadge;

  /// Mode `default`.
  static const NdsRadii defaultMode = NdsRadii(
    radius: 10.0,
    radiusNone: 0.0,
    radiusXs: 4.0,
    radiusSm: 6.0,
    radiusMd: 8.0,
    radiusLg: 10.0,
    radiusXl: 14.0,
    radiusFull: 9999.0,
    radiusButton: 10.0,
    radiusInput: 10.0,
    radiusAlert: 10.0,
    radiusCard: 14.0,
    radiusBadge: 9999.0,
  );

  /// Mode servido quando nenhum é escolhido.
  static const NdsRadii fallback = defaultMode;

  /// Todos os modes por nome — consumido pelos addons do Widgetbook.
  static const Map<String, NdsRadii> byMode = <String, NdsRadii>{
    'default': defaultMode,
  };
}
