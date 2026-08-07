import 'package:flutter/material.dart';

import '../theme/nds_theme.dart';

/// Variante visual do botão — define fundo, texto e borda.
enum NdsButtonVariant { primary, secondary, destructive, outline, ghost, link }

/// Tamanho do botão. Controla padding e tipografia, nunca altura.
enum NdsButtonSize { small, medium, large, icon }

/// Botão do Nortear Design System.
///
/// Duas regras do sistema aparecem aqui como decisão de layout:
///
/// **Sem altura fixa.** O tamanho vem de padding e da altura de linha, não de
/// um `height`. Com altura fixa, o texto vaza ou é cortado quando o usuário
/// aumenta a fonte do sistema — é a leitura Flutter do WCAG 1.4.4, e o addon
/// TextScale do Widgetbook existe para provar que continua valendo.
///
/// **Alvo de toque mínimo de 48dp.** É `minHeight` numa constraint, não altura:
/// o botão pode crescer com a fonte, mas nunca encolhe abaixo do alvo. Esse
/// mínimo é maior que o da web (24px), então o padding vertical dos tokens não
/// é herdado direto — ele é o piso, e a constraint é o piso do piso.
class NdsButton extends StatelessWidget {
  const NdsButton({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
    this.variant = NdsButtonVariant.primary,
    this.size = NdsButtonSize.medium,
    this.loading = false,
    this.semanticLabel,
  }) : assert(
          label != null || icon != null,
          'NdsButton precisa de label ou icon.',
        ),
        assert(
          label != null || semanticLabel != null,
          'Botão sem label visível precisa de semanticLabel — sem isso o leitor '
          'de tela anuncia só "botão".',
        );

  /// `null` desabilita o botão — mesma convenção dos botões do Material.
  final VoidCallback? onPressed;

  final String? label;
  final IconData? icon;
  final NdsButtonVariant variant;
  final NdsButtonSize size;

  /// Enquanto carrega, o botão não dispara, mas continua focável e anunciado.
  final bool loading;

  /// Texto para o leitor de tela quando não há label visível.
  final String? semanticLabel;

  bool get _enabled => onPressed != null && !loading;

  @override
  Widget build(BuildContext context) {
    final NdsTheme t = NdsTheme.of(context);
    final _Palette palette = _paletteFor(t, variant);
    final EdgeInsets padding = _paddingFor(t, size);
    final double fontSize = size == NdsButtonSize.small ? t.typography.textLabel : t.typography.textP;

    final TextStyle textStyle = TextStyle(
      fontFamily: t.fonts.fontFamilyActive,
      fontSize: fontSize,
      fontWeight: _weightFrom(t.typography.fontWeightMedium),
      height: t.typography.lineHeightTight,
      // letterSpacing do Flutter é em pixels lógicos; o token está em em.
      letterSpacing: t.typography.letterSpacingNormalEm * fontSize,
      decoration: variant == NdsButtonVariant.link ? TextDecoration.underline : TextDecoration.none,
    );

    final Color foreground = _enabled ? palette.foreground : palette.foreground.withValues(alpha: 0.5);

    return Semantics(
      button: true,
      enabled: _enabled,
      label: semanticLabel ?? label,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _minTapTarget, minWidth: _minTapTarget),
        child: Material(
          color: _enabled ? palette.background : palette.background.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(t.radii.radiusButton),
          child: InkWell(
            onTap: _enabled ? onPressed : null,
            borderRadius: BorderRadius.circular(t.radii.radiusButton),
            focusColor: t.colors.ring.withValues(alpha: 0.12),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(t.radii.radiusButton),
                border: palette.border == null
                    ? null
                    : Border.all(color: palette.border!, width: t.dimensions.borderWidthDefault),
              ),
              child: Padding(
                padding: padding,
                child: _content(t, textStyle, foreground),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(NdsTheme t, TextStyle textStyle, Color foreground) {
    if (loading) {
      return Center(
        child: SizedBox(
          width: t.dimensions.sizeSm,
          height: t.dimensions.sizeSm,
          child: CircularProgressIndicator(strokeWidth: 2, color: foreground),
        ),
      );
    }

    final Widget? iconWidget = icon == null
        ? null
        : Icon(icon, size: t.dimensions.sizeSm, color: foreground);
    final Widget? labelWidget = label == null
        ? null
        : Text(label!, style: textStyle.copyWith(color: foreground), textAlign: TextAlign.center);

    if (iconWidget != null && labelWidget != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          iconWidget,
          SizedBox(width: t.dimensions.spacing2),
          Flexible(child: labelWidget),
        ],
      );
    }
    return Center(child: labelWidget ?? iconWidget!);
  }

  EdgeInsets _paddingFor(NdsTheme t, NdsButtonSize size) {
    switch (size) {
      case NdsButtonSize.small:
        return EdgeInsets.symmetric(horizontal: t.dimensions.spacingBtnXSm, vertical: t.dimensions.spacing2);
      case NdsButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: t.dimensions.spacingBtnX, vertical: t.dimensions.spacing2);
      case NdsButtonSize.large:
        return EdgeInsets.symmetric(horizontal: t.dimensions.spacingBtnXLg, vertical: t.dimensions.spacing4);
      case NdsButtonSize.icon:
        return EdgeInsets.all(t.dimensions.spacing2);
    }
  }

  _Palette _paletteFor(NdsTheme t, NdsButtonVariant variant) {
    final NdsColors c = t.colors;
    switch (variant) {
      case NdsButtonVariant.primary:
        return _Palette(c.primary, c.primaryForeground, null);
      case NdsButtonVariant.secondary:
        return _Palette(c.secondary, c.secondaryForeground, null);
      case NdsButtonVariant.destructive:
        return _Palette(c.destructive, c.destructiveForeground, null);
      case NdsButtonVariant.outline:
        return _Palette(Colors.transparent, c.foreground, c.border);
      case NdsButtonVariant.ghost:
        return _Palette(Colors.transparent, c.foreground, null);
      case NdsButtonVariant.link:
        return _Palette(Colors.transparent, c.primary, null);
    }
  }
}

/// Mínimo do Material para alvo de toque. O iOS pede 44pt; 48 atende os dois.
const double _minTapTarget = 48;

/// Peso numérico do token (400, 500, 600, 800) → `FontWeight`.
///
/// Indexar `FontWeight.values` por aritmética funcionaria e seria ilegível; um
/// peso fora da escala cairia num índice válido e erraria em silêncio.
FontWeight _weightFrom(double weight) {
  switch (weight.round()) {
    case 100:
      return FontWeight.w100;
    case 200:
      return FontWeight.w200;
    case 300:
      return FontWeight.w300;
    case 500:
      return FontWeight.w500;
    case 600:
      return FontWeight.w600;
    case 700:
      return FontWeight.w700;
    case 800:
      return FontWeight.w800;
    case 900:
      return FontWeight.w900;
    default:
      return FontWeight.w400;
  }
}

@immutable
class _Palette {
  const _Palette(this.background, this.foreground, this.border);
  final Color background;
  final Color foreground;
  final Color? border;
}
