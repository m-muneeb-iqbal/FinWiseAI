import 'package:flutter/material.dart';

class AppDrawerTheme extends ThemeExtension<AppDrawerTheme> {
  final BoxDecoration headerDecoration;
  final Color surfaceColor;
  final Color itemColor;
  final Color iconColor;
  final Color accountIconColor;

  const AppDrawerTheme({
    required this.headerDecoration,
    required this.surfaceColor,
    required this.itemColor,
    required this.iconColor,
    required this.accountIconColor,
  });

  @override
  AppDrawerTheme copyWith({
    BoxDecoration? headerDecoration,
    Color? surfaceColor,
    Color? itemColor,
    Color? iconColor,
    Color? accountIconColor,
  }) {
    return AppDrawerTheme(
      headerDecoration: headerDecoration ?? this.headerDecoration,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      itemColor: itemColor ?? this.itemColor,
      iconColor: iconColor ?? this.iconColor,
      accountIconColor: accountIconColor ?? this.accountIconColor,
    );
  }

  @override
  AppDrawerTheme lerp(ThemeExtension<AppDrawerTheme>? other, double t) => this;
}
