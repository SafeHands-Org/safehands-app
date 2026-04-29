import "package:flutter/material.dart";

abstract final class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const base = 16.0;
  static const lg = 20.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

abstract final class AppRadius {
  static const sm = Radius.circular(4.0);
  static const md = Radius.circular(8.0);
  static const lg = Radius.circular(10.0);
  static const xl = Radius.circular(14.0);
  static const card = Radius.circular(16.0);
  static const pill = Radius.circular(100.0);

  static const borderRadiusSm = BorderRadius.all(sm);
  static const borderRadiusMd = BorderRadius.all(md);
  static const borderRadiusLg = BorderRadius.all(lg);
  static const borderRadiusXl = BorderRadius.all(xl);
  static const borderRadiusCard = BorderRadius.all(card);
  static const borderRadiusPill = BorderRadius.all(pill);
}
