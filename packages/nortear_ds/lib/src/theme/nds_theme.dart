import 'package:flutter/material.dart';

import '../tokens/tokens.g.dart';

/// Tokens do Nortear DS disponíveis via `Theme.of(context)`.
///
/// Os tokens são gerados a partir do `@nortear/ds-core` e não conhecem Flutter.
/// Esta extensão é a ponte: leva o conjunto escolhido (tema × modo × densidade ×
/// escala) para dentro do `ThemeData`, que é como um widget do Flutter espera
/// receber design tokens.
///
/// A cor semântica fica AQUI, não no `ColorScheme`. O `ColorScheme` do Material
/// tem papéis próprios (primary/surface/error) que não cobrem os do sistema —
/// `success`, `warning`, `info`, os cinco de gráfico e os da sidebar não teriam
/// onde morar. `NdsTheme.of(context)` é a fonte para componentes do DS;
/// `ColorScheme` continua preenchido para os widgets nativos do Material.
@immutable
class NdsTheme extends ThemeExtension<NdsTheme> {
  const NdsTheme({
    required this.colors,
    required this.dimensions,
    required this.radii,
    required this.typography,
    required this.motion,
    required this.elevation,
    required this.fonts,
  });

  final NdsColors colors;
  final NdsDimensions dimensions;
  final NdsRadii radii;
  final NdsTypography typography;
  final NdsMotion motion;
  final NdsElevation elevation;
  final NdsFonts fonts;

  /// Tokens do tema atual.
  ///
  /// Lança se `NortearTheme.data()` não montou o `ThemeData` — falhar aqui é
  /// melhor que servir um fallback silencioso e o app inteiro renderizar com o
  /// tema errado sem ninguém notar.
  static NdsTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<NdsTheme>();
    assert(theme != null, 'NdsTheme ausente — monte o ThemeData com NortearTheme.data().');
    return theme ?? fallback;
  }

  static const NdsTheme fallback = NdsTheme(
    colors: NdsColors.fallback,
    dimensions: NdsDimensions.fallback,
    radii: NdsRadii.fallback,
    typography: NdsTypography.fallback,
    motion: NdsMotion.fallback,
    elevation: NdsElevation.fallback,
    fonts: NdsFonts.fallback,
  );

  @override
  NdsTheme copyWith({
    NdsColors? colors,
    NdsDimensions? dimensions,
    NdsRadii? radii,
    NdsTypography? typography,
    NdsMotion? motion,
    NdsElevation? elevation,
    NdsFonts? fonts,
  }) {
    return NdsTheme(
      colors: colors ?? this.colors,
      dimensions: dimensions ?? this.dimensions,
      radii: radii ?? this.radii,
      typography: typography ?? this.typography,
      motion: motion ?? this.motion,
      elevation: elevation ?? this.elevation,
      fonts: fonts ?? this.fonts,
    );
  }

  /// Troca de tema não interpola.
  ///
  /// Os conjuntos de token são discretos — não existe "meio caminho entre o
  /// tema warm e o cold", e interpolar produziria cores fora da paleta durante
  /// a transição. O corte acontece na metade.
  @override
  NdsTheme lerp(ThemeExtension<NdsTheme>? other, double t) {
    if (other is! NdsTheme) return this;
    return t < 0.5 ? this : other;
  }
}

/// Monta o `ThemeData` do Nortear DS.
abstract final class NortearTheme {
  /// Nomes de tema aceitos por [data] — os modes da coleção `Cor`, sem o sufixo
  /// de brilho. Consumido pelo addon de tema do Widgetbook.
  static const List<String> brands = <String>['default', 'warm', 'cold'];

  static ThemeData data({
    String brand = 'default',
    Brightness brightness = Brightness.light,
    String density = 'default',
    String typeScale = 'minor-third',
    String font = 'default',
  }) {
    final String bright = brightness == Brightness.dark ? 'dark' : 'light';

    final NdsTheme tokens = NdsTheme(
      colors: _pick(NdsColors.byMode, '$brand-$bright', NdsColors.fallback),
      dimensions: _pick(NdsDimensions.byMode, density, NdsDimensions.fallback),
      radii: NdsRadii.fallback,
      typography: _pick(NdsTypography.byMode, typeScale, NdsTypography.fallback),
      motion: NdsMotion.fallback,
      elevation: _pick(NdsElevation.byMode, bright, NdsElevation.fallback),
      fonts: _pick(NdsFonts.byMode, font, NdsFonts.fallback),
    );

    final NdsColors c = tokens.colors;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: tokens.fonts.fontFamilyActive,
      scaffoldBackgroundColor: c.background,
      // Os widgets nativos do Material continuam lendo daqui; o mapeamento é
      // aproximado de propósito, porque os papéis não são os mesmos.
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: c.primary,
        onPrimary: c.primaryForeground,
        secondary: c.secondary,
        onSecondary: c.secondaryForeground,
        error: c.destructive,
        onError: c.destructiveForeground,
        surface: c.card,
        onSurface: c.cardForeground,
        outline: c.border,
      ),
      extensions: <ThemeExtension<dynamic>>[tokens],
    );
  }

  static T _pick<T>(Map<String, T> byMode, String key, T fallback) {
    return byMode[key] ?? fallback;
  }
}
