import 'package:flutter/material.dart';

class PaletteExtension extends ThemeExtension<PaletteExtension> {
  const PaletteExtension({
    required this.header,
    required this.page,
    required this.statusUpToDate,
    required this.statusPending,
    required this.statusMissed,
    required this.statusAttention,
    required this.categoryBlue,
    required this.categoryBlueContainer,
    required this.categoryGreen,
    required this.categoryGreenContainer,
    required this.categoryOrange,
    required this.categoryOrangeContainer,
    required this.categoryIndigo,
    required this.categoryIndigoContainer,
    required this.categoryCyan,
    required this.categoryCyanContainer,
    required this.statusUpToDateContainer,
    required this.statusPendingContainer,
    required this.statusMissedContainer,
    required this.statusAttentionContainer,
    required this.gradientBlue,
    required this.gradientGreen,
    required this.gradientOrange,
  });

  final LinearGradient header;
  final LinearGradient page;
  final Color statusUpToDate;
  final Color statusPending;
  final Color statusMissed;
  final Color statusAttention;

  final Color categoryBlue;
  final Color categoryBlueContainer;
  final Color categoryGreen;
  final Color categoryGreenContainer;
  final Color categoryOrange;
  final Color categoryOrangeContainer;
  final Color categoryIndigo;
  final Color categoryIndigoContainer;
  final Color categoryCyan;
  final Color categoryCyanContainer;

  final Color statusUpToDateContainer;
  final Color statusPendingContainer;
  final Color statusMissedContainer;
  final Color statusAttentionContainer;

  final LinearGradient gradientBlue;
  final LinearGradient gradientGreen;
  final LinearGradient gradientOrange;

  factory PaletteExtension.light() => const PaletteExtension(
    header: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF785C99), Color(0xFF6A5EA0), Color(0xFF6D71B4)],
    ),
    page: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFEEDBFF), Color(0xFFE1DDFF)],
    ),
    statusUpToDate:  Color(0xFF4D9C6E),
    statusPending:   Color(0xFF6D71B4),
    statusMissed:    Color(0xFFC84750),
    statusAttention: Color(0xFFB8872A),

    categoryBlue:          Color(0xFF3B82F6),
    categoryBlueContainer: Color(0xFFEFF6FF),
    categoryGreen:          Color(0xFF22C55E),
    categoryGreenContainer: Color(0xFFF0FDF4),
    categoryOrange:          Color(0xFFF97316),
    categoryOrangeContainer: Color(0xFFFFF7ED),
    categoryIndigo:          Color(0xFF6366F1),
    categoryIndigoContainer: Color(0xFFEEF2FF),
    categoryCyan:          Color(0xFF06B6D4),
    categoryCyanContainer: Color(0xFFECFEFF),

    statusUpToDateContainer:  Color(0xFFDCFCE7),
    statusPendingContainer:   Color(0xFFEDE9FE),
    statusMissedContainer:    Color(0xFFFFE4E6),
    statusAttentionContainer: Color(0xFFFEF3C7),

    gradientBlue: LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight,
      colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
    ),
    gradientGreen: LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight,
      colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
    ),
    gradientOrange: LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight,
      colors: [Color(0xFFF97316), Color(0xFFEA580C)],
    ),
  );

  factory PaletteExtension.dark() => const PaletteExtension(
    header: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF785C99), Color(0xFF6A5EA0), Color(0xFF6D71B4)],
    ),
    page: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF785C99), Color(0xFF6D71B4)],
    ),

    statusUpToDate:  Color(0xFF6DBF8E),
    statusPending:   Color(0xFFE1DDFF),
    statusMissed:    Color(0xFFC84750),
    statusAttention: Color(0xFFD4A955),

    categoryBlue:          Color(0xFF60A5FA),
    categoryBlueContainer: Color(0xFF1E3A5F),
    categoryGreen:          Color(0xFF4ADE80),
    categoryGreenContainer: Color(0xFF14532D),
    categoryOrange:          Color(0xFFFB923C),
    categoryOrangeContainer: Color(0xFF7C2D12),
    categoryIndigo:          Color(0xFF818CF8),
    categoryIndigoContainer: Color(0xFF1E1B4B),
    categoryCyan:          Color(0xFF22D3EE),
    categoryCyanContainer: Color(0xFF164E63),

    statusUpToDateContainer:  Color(0xFF14532D),
    statusPendingContainer:   Color(0xFF2E1065),
    statusMissedContainer:    Color(0xFF7F1D1D),
    statusAttentionContainer: Color(0xFF78350F),

    gradientBlue: LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight,
      colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)],
    ),
    gradientGreen: LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight,
      colors: [Color(0xFF4ADE80), Color(0xFF22C55E)],
    ),
    gradientOrange: LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight,
      colors: [Color(0xFFFB923C), Color(0xFFF97316)],
    ),
  );

@override
PaletteExtension copyWith({
  LinearGradient? header,
  LinearGradient? page,
  Color? statusUpToDate,
  Color? statusPending,
  Color? statusMissed,
  Color? statusAttention,
  Color? categoryBlue,
  Color? categoryBlueContainer,
  Color? categoryGreen,
  Color? categoryGreenContainer,
  Color? categoryOrange,
  Color? categoryOrangeContainer,
  Color? categoryIndigo,
  Color? categoryIndigoContainer,
  Color? categoryCyan,
  Color? categoryCyanContainer,
  Color? statusUpToDateContainer,
  Color? statusPendingContainer,
  Color? statusMissedContainer,
  Color? statusAttentionContainer,
  LinearGradient? gradientBlue,
  LinearGradient? gradientGreen,
  LinearGradient? gradientOrange,
}) {
  return PaletteExtension(
    header:                     header                   ?? this.header,
    page:                       page                     ?? this.page,
    statusUpToDate:             statusUpToDate           ?? this.statusUpToDate,
    statusPending:              statusPending            ?? this.statusPending,
    statusMissed:               statusMissed             ?? this.statusMissed,
    statusAttention:            statusAttention          ?? this.statusAttention,
    categoryBlue:               categoryBlue             ?? this.categoryBlue,
    categoryBlueContainer:      categoryBlueContainer    ?? this.categoryBlueContainer,
    categoryGreen:              categoryGreen            ?? this.categoryGreen,
    categoryGreenContainer:     categoryGreenContainer   ?? this.categoryGreenContainer,
    categoryOrange:             categoryOrange           ?? this.categoryOrange,
    categoryOrangeContainer:    categoryOrangeContainer  ?? this.categoryOrangeContainer,
    categoryIndigo:             categoryIndigo           ?? this.categoryIndigo,
    categoryIndigoContainer:    categoryIndigoContainer  ?? this.categoryIndigoContainer,
    categoryCyan:               categoryCyan             ?? this.categoryCyan,
    categoryCyanContainer:      categoryCyanContainer    ?? this.categoryCyanContainer,
    statusUpToDateContainer:    statusUpToDateContainer  ?? this.statusUpToDateContainer,
    statusPendingContainer:     statusPendingContainer   ?? this.statusPendingContainer,
    statusMissedContainer:      statusMissedContainer    ?? this.statusMissedContainer,
    statusAttentionContainer:   statusAttentionContainer ?? this.statusAttentionContainer,
    gradientBlue:               gradientBlue             ?? this.gradientBlue,
    gradientGreen:              gradientGreen            ?? this.gradientGreen,
    gradientOrange:             gradientOrange           ?? this.gradientOrange,
  );
}

@override
PaletteExtension lerp(ThemeExtension<PaletteExtension>? other, double t) {
  if (other is! PaletteExtension) return this;
  return PaletteExtension(
    header:                       (Gradient.lerp(header, other.header, t) ?? header) as LinearGradient,
    page:                         (Gradient.lerp(page, other.page, t) ?? header) as LinearGradient,
    gradientBlue:                 (Gradient.lerp(gradientBlue,          other.gradientBlue,             t) ?? gradientBlue)   as LinearGradient,
    gradientGreen:                (Gradient.lerp(gradientGreen,         other.gradientGreen,            t) ?? gradientGreen)  as LinearGradient,
    gradientOrange:               (Gradient.lerp(gradientOrange,        other.gradientOrange,           t) ?? gradientOrange) as LinearGradient,

    statusUpToDate:               Color.lerp(statusUpToDate,            other.statusUpToDate,           t)!,
    statusPending:                Color.lerp(statusPending,             other.statusPending,            t)!,
    statusMissed:                 Color.lerp(statusMissed,              other.statusMissed,             t)!,
    statusAttention:              Color.lerp(statusAttention,           other.statusAttention,          t)!,

    categoryBlue:                 Color.lerp(categoryBlue,              other.categoryBlue,             t)!,
    categoryBlueContainer:        Color.lerp(categoryBlueContainer,     other.categoryBlueContainer,    t)!,
    categoryGreen:                Color.lerp(categoryGreen,             other.categoryGreen,            t)!,
    categoryGreenContainer:       Color.lerp(categoryGreenContainer,    other.categoryGreenContainer,   t)!,
    categoryOrange:               Color.lerp(categoryOrange,            other.categoryOrange,           t)!,
    categoryOrangeContainer:      Color.lerp(categoryOrangeContainer,   other.categoryOrangeContainer,  t)!,
    categoryIndigo:               Color.lerp(categoryIndigo,            other.categoryIndigo,           t)!,
    categoryIndigoContainer:      Color.lerp(categoryIndigoContainer,   other.categoryIndigoContainer,  t)!,
    categoryCyan:                 Color.lerp(categoryCyan,              other.categoryCyan,             t)!,
    categoryCyanContainer:        Color.lerp(categoryCyanContainer,     other.categoryCyanContainer,    t)!,

    statusUpToDateContainer:      Color.lerp(statusUpToDateContainer,   other.statusUpToDateContainer,  t)!,
    statusPendingContainer:       Color.lerp(statusPendingContainer,    other.statusPendingContainer,   t)!,
    statusMissedContainer:        Color.lerp(statusMissedContainer,     other.statusMissedContainer,    t)!,
    statusAttentionContainer:     Color.lerp(statusAttentionContainer,  other.statusAttentionContainer, t)!,
    );
  }
}

extension PaletteX on BuildContext {
  PaletteExtension get palette => Theme.of(this).extension<PaletteExtension>()!;
}