// GERADO por tool/generate-tokens.mjs — não editar à mão.
//
// Fonte: @nortear/ds-core · tokens/figma-variables.json · coleção "Cor"
// Para atualizar: npm run core:sync && npm run tokens:gen

// widgets.dart reexporta foundation (immutable), painting (Color, BoxShadow,
// Offset) e animation (Curve, Cubic, Curves) — um import cobre todo tipo emitido.
import 'package:flutter/widgets.dart';

/// Tokens da coleção "Cor".
///
/// Modes: default-light, default-dark, warm-light, warm-dark, cold-light, cold-dark.
@immutable
class NdsColors {
  const NdsColors({
    required this.background,
    required this.foreground,
    required this.card,
    required this.cardForeground,
    required this.popover,
    required this.popoverForeground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.muted,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.success,
    required this.successForeground,
    required this.warning,
    required this.warningForeground,
    required this.info,
    required this.infoForeground,
    required this.border,
    required this.input,
    required this.inputBackground,
    required this.ring,
    required this.ringOffsetColor,
    required this.chart1,
    required this.chart2,
    required this.chart3,
    required this.chart4,
    required this.chart5,
    required this.sidebar,
    required this.sidebarForeground,
    required this.sidebarPrimary,
    required this.sidebarPrimaryForeground,
    required this.sidebarAccent,
    required this.sidebarAccentForeground,
    required this.sidebarBorder,
    required this.sidebarRing,
    required this.codeTokenComment,
    required this.codeTokenString,
    required this.codeTokenNumber,
    required this.codeTokenKeyword,
    required this.codeTokenBuiltin,
    required this.codeTokenFunction,
    required this.codeTokenTag,
    required this.codeTokenAttr,
    required this.codeTokenProperty,
    required this.codeTokenOperator,
    required this.codeTokenPunctuation,
  });

  /// `background`
  final Color background;
  /// `foreground`
  final Color foreground;
  /// `card`
  final Color card;
  /// `card-foreground`
  final Color cardForeground;
  /// `popover`
  final Color popover;
  /// `popover-foreground`
  final Color popoverForeground;
  /// `primary`
  final Color primary;
  /// `primary-foreground`
  final Color primaryForeground;
  /// `secondary`
  final Color secondary;
  /// `secondary-foreground`
  final Color secondaryForeground;
  /// `muted`
  final Color muted;
  /// `muted-foreground`
  final Color mutedForeground;
  /// `accent`
  final Color accent;
  /// `accent-foreground`
  final Color accentForeground;
  /// `destructive`
  final Color destructive;
  /// `destructive-foreground`
  final Color destructiveForeground;
  /// `success`
  final Color success;
  /// `success-foreground`
  final Color successForeground;
  /// `warning`
  final Color warning;
  /// `warning-foreground`
  final Color warningForeground;
  /// `info`
  final Color info;
  /// `info-foreground`
  final Color infoForeground;
  /// `border`
  final Color border;
  /// `input`
  final Color input;
  /// `input-background`
  final Color inputBackground;
  /// `ring`
  final Color ring;
  /// `ring-offset-color`
  final Color ringOffsetColor;
  /// `chart-1`
  final Color chart1;
  /// `chart-2`
  final Color chart2;
  /// `chart-3`
  final Color chart3;
  /// `chart-4`
  final Color chart4;
  /// `chart-5`
  final Color chart5;
  /// `sidebar`
  final Color sidebar;
  /// `sidebar-foreground`
  final Color sidebarForeground;
  /// `sidebar-primary`
  final Color sidebarPrimary;
  /// `sidebar-primary-foreground`
  final Color sidebarPrimaryForeground;
  /// `sidebar-accent`
  final Color sidebarAccent;
  /// `sidebar-accent-foreground`
  final Color sidebarAccentForeground;
  /// `sidebar-border`
  final Color sidebarBorder;
  /// `sidebar-ring`
  final Color sidebarRing;
  /// `code-token-comment`
  final Color codeTokenComment;
  /// `code-token-string`
  final Color codeTokenString;
  /// `code-token-number`
  final Color codeTokenNumber;
  /// `code-token-keyword`
  final Color codeTokenKeyword;
  /// `code-token-builtin`
  final Color codeTokenBuiltin;
  /// `code-token-function`
  final Color codeTokenFunction;
  /// `code-token-tag`
  final Color codeTokenTag;
  /// `code-token-attr`
  final Color codeTokenAttr;
  /// `code-token-property`
  final Color codeTokenProperty;
  /// `code-token-operator`
  final Color codeTokenOperator;
  /// `code-token-punctuation`
  final Color codeTokenPunctuation;

  /// Mode `default-light`.
  static const NdsColors defaultLight = NdsColors(
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF0A0A0A),
    card: Color(0xFFFFFFFF),
    cardForeground: Color(0xFF0A0A0A),
    popover: Color(0xFFFFFFFF),
    popoverForeground: Color(0xFF0A0A0A),
    primary: Color(0xFF171717),
    primaryForeground: Color(0xFFFAFAFA),
    secondary: Color(0xFFF5F5F5),
    secondaryForeground: Color(0xFF0A0A0A),
    muted: Color(0xFFF5F5F5),
    mutedForeground: Color(0xFF666666),
    accent: Color(0xFFF5F5F5),
    accentForeground: Color(0xFF171717),
    destructive: Color(0xFFBA1C1C),
    destructiveForeground: Color(0xFFFFFFFF),
    success: Color(0xFF08682B),
    successForeground: Color(0xFFFFFFFF),
    warning: Color(0xFFB38705),
    warningForeground: Color(0xFFFFFFFF),
    info: Color(0xFF134CC9),
    infoForeground: Color(0xFFFFFFFF),
    border: Color(0xFFE6E6E6),
    input: Color(0xFFE6E6E6),
    inputBackground: Color(0xFFFFFFFF),
    ring: Color(0xFF737373),
    ringOffsetColor: Color(0xFFFFFFFF),
    chart1: Color(0xFF56C3F5),
    chart2: Color(0xFF00AAFF),
    chart3: Color(0xFF029EF2),
    chart4: Color(0xFF0D8BCE),
    chart5: Color(0xFF113B64),
    sidebar: Color(0xFFFAFAFA),
    sidebarForeground: Color(0xFF0A0A0A),
    sidebarPrimary: Color(0xFF171717),
    sidebarPrimaryForeground: Color(0xFFFAFAFA),
    sidebarAccent: Color(0xFFF5F5F5),
    sidebarAccentForeground: Color(0xFF171717),
    sidebarBorder: Color(0xFFD4D4D4),
    sidebarRing: Color(0xFF737373),
    codeTokenComment: Color(0xFF575757),
    codeTokenString: Color(0xFF165F35),
    codeTokenNumber: Color(0xFF863D09),
    codeTokenKeyword: Color(0xFF5D26AB),
    codeTokenBuiltin: Color(0xFF0A557B),
    codeTokenFunction: Color(0xFF184C95),
    codeTokenTag: Color(0xFF9E1A30),
    codeTokenAttr: Color(0xFF782C8C),
    codeTokenProperty: Color(0xFF075D6E),
    codeTokenOperator: Color(0xFF424242),
    codeTokenPunctuation: Color(0xFF575757),
  );

  /// Mode `default-dark`.
  static const NdsColors defaultDark = NdsColors(
    background: Color(0xFF171717),
    foreground: Color(0xFFFAFAFA),
    card: Color(0xFF171717),
    cardForeground: Color(0xFFFAFAFA),
    popover: Color(0xFF171717),
    popoverForeground: Color(0xFFFAFAFA),
    primary: Color(0xFFFAFAFA),
    primaryForeground: Color(0xFF171717),
    secondary: Color(0xFF262626),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF262626),
    mutedForeground: Color(0xFFB3B3B3),
    accent: Color(0xFF262626),
    accentForeground: Color(0xFFFAFAFA),
    destructive: Color(0xFFF47171),
    destructiveForeground: Color(0xFFFFFFFF),
    success: Color(0xFF3BDE77),
    successForeground: Color(0xFF000000),
    warning: Color(0xFFFAD338),
    warningForeground: Color(0xFF000000),
    info: Color(0xFF2463EB),
    infoForeground: Color(0xFFFFFFFF),
    border: Color(0xFF262626),
    input: Color(0xFF262626),
    inputBackground: Color(0xFF171717),
    ring: Color(0xFF737373),
    ringOffsetColor: Color(0xFF171717),
    chart1: Color(0xFF56C3F5),
    chart2: Color(0xFF00AAFF),
    chart3: Color(0xFF029EF2),
    chart4: Color(0xFF0D8BCE),
    chart5: Color(0xFF113B64),
    sidebar: Color(0xFF171717),
    sidebarForeground: Color(0xFFFAFAFA),
    sidebarPrimary: Color(0xFFFAFAFA),
    sidebarPrimaryForeground: Color(0xFF171717),
    sidebarAccent: Color(0xFF262626),
    sidebarAccentForeground: Color(0xFFFAFAFA),
    sidebarBorder: Color(0xFF262626),
    sidebarRing: Color(0xFF737373),
    codeTokenComment: Color(0xFFB3B3B3),
    codeTokenString: Color(0xFF8BDAAC),
    codeTokenNumber: Color(0xFFF6AD79),
    codeTokenKeyword: Color(0xFFCBABF7),
    codeTokenBuiltin: Color(0xFF7ECBF1),
    codeTokenFunction: Color(0xFF96BFF8),
    codeTokenTag: Color(0xFFF490A0),
    codeTokenAttr: Color(0xFFE4B2F0),
    codeTokenProperty: Color(0xFF73D5E8),
    codeTokenOperator: Color(0xFFD1D1D1),
    codeTokenPunctuation: Color(0xFFB3B3B3),
  );

  /// Mode `warm-light`.
  static const NdsColors warmLight = NdsColors(
    background: Color(0xFFFDFCFC),
    foreground: Color(0xFF181410),
    card: Color(0xFFFDFCFC),
    cardForeground: Color(0xFF181410),
    popover: Color(0xFFFDFCFC),
    popoverForeground: Color(0xFF181410),
    primary: Color(0xFF9C3E16),
    primaryForeground: Color(0xFFFBFAF8),
    secondary: Color(0xFFF6ECDF),
    secondaryForeground: Color(0xFF5A2B16),
    muted: Color(0xFFF5F2F0),
    mutedForeground: Color(0xFF78695E),
    accent: Color(0xFFF6ECDF),
    accentForeground: Color(0xFF5A2B16),
    destructive: Color(0xFFBA1C1C),
    destructiveForeground: Color(0xFFFFFFFF),
    success: Color(0xFF1D722B),
    successForeground: Color(0xFFFFFFFF),
    warning: Color(0xFFBD5B05),
    warningForeground: Color(0xFFFFFFFF),
    info: Color(0xFFD45F11),
    infoForeground: Color(0xFFFFFFFF),
    border: Color(0xFFE5E0DC),
    input: Color(0xFFE5E0DC),
    inputBackground: Color(0xFFFDFCFC),
    ring: Color(0xFFC9501D),
    ringOffsetColor: Color(0xFFFDFCFC),
    chart1: Color(0xFFFA9F38),
    chart2: Color(0xFFF2690D),
    chart3: Color(0xFFD44C11),
    chart4: Color(0xFFE29D36),
    chart5: Color(0xFFAD401F),
    sidebar: Color(0xFFFBFAF9),
    sidebarForeground: Color(0xFF181410),
    sidebarPrimary: Color(0xFF9C3E16),
    sidebarPrimaryForeground: Color(0xFFFBFAF8),
    sidebarAccent: Color(0xFFF6ECDF),
    sidebarAccentForeground: Color(0xFF5A2B16),
    sidebarBorder: Color(0xFFDED9D3),
    sidebarRing: Color(0xFFC9501D),
    codeTokenComment: Color(0xFF575757),
    codeTokenString: Color(0xFF165F35),
    codeTokenNumber: Color(0xFF863D09),
    codeTokenKeyword: Color(0xFF5D26AB),
    codeTokenBuiltin: Color(0xFF0A557B),
    codeTokenFunction: Color(0xFF184C95),
    codeTokenTag: Color(0xFF9E1A30),
    codeTokenAttr: Color(0xFF782C8C),
    codeTokenProperty: Color(0xFF075D6E),
    codeTokenOperator: Color(0xFF424242),
    codeTokenPunctuation: Color(0xFF575757),
  );

  /// Mode `warm-dark`.
  static const NdsColors warmDark = NdsColors(
    background: Color(0xFF1A1614),
    foreground: Color(0xFFF7F5F3),
    card: Color(0xFF1A1614),
    cardForeground: Color(0xFFF7F5F3),
    popover: Color(0xFF1A1614),
    popoverForeground: Color(0xFFF7F5F3),
    primary: Color(0xFFF08242),
    primaryForeground: Color(0xFF211812),
    secondary: Color(0xFF372C25),
    secondaryForeground: Color(0xFFF4E8D7),
    muted: Color(0xFF2D2825),
    mutedForeground: Color(0xFFBCB3A9),
    accent: Color(0xFF372C25),
    accentForeground: Color(0xFFF4E8D7),
    destructive: Color(0xFFED5E5E),
    destructiveForeground: Color(0xFFFFFFFF),
    success: Color(0xFF47D15E),
    successForeground: Color(0xFF000000),
    warning: Color(0xFFF69E23),
    warningForeground: Color(0xFF000000),
    info: Color(0xFFEF8239),
    infoForeground: Color(0xFFFFFFFF),
    border: Color(0xFF2D2825),
    input: Color(0xFF2D2825),
    inputBackground: Color(0xFF1A1614),
    ring: Color(0xFFEE722B),
    ringOffsetColor: Color(0xFF1A1614),
    chart1: Color(0xFFFA9F38),
    chart2: Color(0xFFF2690D),
    chart3: Color(0xFFD44C11),
    chart4: Color(0xFFE29D36),
    chart5: Color(0xFFAD401F),
    sidebar: Color(0xFF1A1614),
    sidebarForeground: Color(0xFFF7F5F3),
    sidebarPrimary: Color(0xFFF08242),
    sidebarPrimaryForeground: Color(0xFF211812),
    sidebarAccent: Color(0xFF372C25),
    sidebarAccentForeground: Color(0xFFF4E8D7),
    sidebarBorder: Color(0xFF2D2825),
    sidebarRing: Color(0xFFEE722B),
    codeTokenComment: Color(0xFFB3B3B3),
    codeTokenString: Color(0xFF8BDAAC),
    codeTokenNumber: Color(0xFFF6AD79),
    codeTokenKeyword: Color(0xFFCBABF7),
    codeTokenBuiltin: Color(0xFF7ECBF1),
    codeTokenFunction: Color(0xFF96BFF8),
    codeTokenTag: Color(0xFFF490A0),
    codeTokenAttr: Color(0xFFE4B2F0),
    codeTokenProperty: Color(0xFF73D5E8),
    codeTokenOperator: Color(0xFFD1D1D1),
    codeTokenPunctuation: Color(0xFFB3B3B3),
  );

  /// Mode `cold-light`.
  static const NdsColors coldLight = NdsColors(
    background: Color(0xFFFCFCFD),
    foreground: Color(0xFF0F141A),
    card: Color(0xFFFCFCFD),
    cardForeground: Color(0xFF0F141A),
    popover: Color(0xFFFCFCFD),
    popoverForeground: Color(0xFF0F141A),
    primary: Color(0xFF1354AE),
    primaryForeground: Color(0xFFF8FAFB),
    secondary: Color(0xFFDFECF6),
    secondaryForeground: Color(0xFF13386C),
    muted: Color(0xFFF0F2F5),
    mutedForeground: Color(0xFF5E6978),
    accent: Color(0xFFDFECF6),
    accentForeground: Color(0xFF13386C),
    destructive: Color(0xFFBB1B36),
    destructiveForeground: Color(0xFFFFFFFF),
    success: Color(0xFF11745B),
    successForeground: Color(0xFFFFFFFF),
    warning: Color(0xFF0476AE),
    warningForeground: Color(0xFFFFFFFF),
    info: Color(0xFF1162D4),
    infoForeground: Color(0xFFFFFFFF),
    border: Color(0xFFDBE0E6),
    input: Color(0xFFDBE0E6),
    inputBackground: Color(0xFFFCFCFD),
    ring: Color(0xFF186ADC),
    ringOffsetColor: Color(0xFFFCFCFD),
    chart1: Color(0xFF3D99F5),
    chart2: Color(0xFF13B6EC),
    chart3: Color(0xFF19B3B3),
    chart4: Color(0xFF305EE8),
    chart5: Color(0xFF2222C3),
    sidebar: Color(0xFFF8FAFB),
    sidebarForeground: Color(0xFF0F141A),
    sidebarPrimary: Color(0xFF1354AE),
    sidebarPrimaryForeground: Color(0xFFF8FAFB),
    sidebarAccent: Color(0xFFDFECF6),
    sidebarAccentForeground: Color(0xFF13386C),
    sidebarBorder: Color(0xFFD2D9E0),
    sidebarRing: Color(0xFF186ADC),
    codeTokenComment: Color(0xFF575757),
    codeTokenString: Color(0xFF165F35),
    codeTokenNumber: Color(0xFF863D09),
    codeTokenKeyword: Color(0xFF5D26AB),
    codeTokenBuiltin: Color(0xFF0A557B),
    codeTokenFunction: Color(0xFF184C95),
    codeTokenTag: Color(0xFF9E1A30),
    codeTokenAttr: Color(0xFF782C8C),
    codeTokenProperty: Color(0xFF075D6E),
    codeTokenOperator: Color(0xFF424242),
    codeTokenPunctuation: Color(0xFF575757),
  );

  /// Mode `cold-dark`.
  static const NdsColors coldDark = NdsColors(
    background: Color(0xFF11161D),
    foreground: Color(0xFFF2F5F7),
    card: Color(0xFF11161D),
    cardForeground: Color(0xFFF2F5F7),
    popover: Color(0xFF11161D),
    popoverForeground: Color(0xFFF2F5F7),
    primary: Color(0xFF479EF5),
    primaryForeground: Color(0xFF121821),
    secondary: Color(0xFF222C39),
    secondaryForeground: Color(0xFFD7E8F4),
    muted: Color(0xFF23282F),
    mutedForeground: Color(0xFFA9B3BC),
    accent: Color(0xFF222C39),
    accentForeground: Color(0xFFD7E8F4),
    destructive: Color(0xFFED5E76),
    destructiveForeground: Color(0xFFFFFFFF),
    success: Color(0xFF26D9AC),
    successForeground: Color(0xFF000000),
    warning: Color(0xFF23AFF6),
    warningForeground: Color(0xFF000000),
    info: Color(0xFF428BF0),
    infoForeground: Color(0xFFFFFFFF),
    border: Color(0xFF23282F),
    input: Color(0xFF23282F),
    inputBackground: Color(0xFF11161D),
    ring: Color(0xFF3494F4),
    ringOffsetColor: Color(0xFF11161D),
    chart1: Color(0xFF3D99F5),
    chart2: Color(0xFF13B6EC),
    chart3: Color(0xFF19B3B3),
    chart4: Color(0xFF305EE8),
    chart5: Color(0xFF2222C3),
    sidebar: Color(0xFF11161D),
    sidebarForeground: Color(0xFFF2F5F7),
    sidebarPrimary: Color(0xFF479EF5),
    sidebarPrimaryForeground: Color(0xFF121821),
    sidebarAccent: Color(0xFF222C39),
    sidebarAccentForeground: Color(0xFFD7E8F4),
    sidebarBorder: Color(0xFF23282F),
    sidebarRing: Color(0xFF3494F4),
    codeTokenComment: Color(0xFFB3B3B3),
    codeTokenString: Color(0xFF8BDAAC),
    codeTokenNumber: Color(0xFFF6AD79),
    codeTokenKeyword: Color(0xFFCBABF7),
    codeTokenBuiltin: Color(0xFF7ECBF1),
    codeTokenFunction: Color(0xFF96BFF8),
    codeTokenTag: Color(0xFFF490A0),
    codeTokenAttr: Color(0xFFE4B2F0),
    codeTokenProperty: Color(0xFF73D5E8),
    codeTokenOperator: Color(0xFFD1D1D1),
    codeTokenPunctuation: Color(0xFFB3B3B3),
  );

  /// Mode servido quando nenhum é escolhido.
  static const NdsColors fallback = defaultLight;

  /// Todos os modes por nome — consumido pelos addons do Widgetbook.
  static const Map<String, NdsColors> byMode = <String, NdsColors>{
    'default-light': defaultLight,
    'default-dark': defaultDark,
    'warm-light': warmLight,
    'warm-dark': warmDark,
    'cold-light': coldLight,
    'cold-dark': coldDark,
  };
}
