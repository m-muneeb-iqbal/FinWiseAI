import 'package:flutter/material.dart';

class AppGradient extends ThemeExtension<AppGradient> {
  final LinearGradient gradient;

  const AppGradient({required this.gradient});

  @override
  AppGradient copyWith({LinearGradient? gradient}) =>
      AppGradient(gradient: gradient ?? this.gradient);

  @override
  AppGradient lerp(ThemeExtension<AppGradient>? other, double t) => this;
}