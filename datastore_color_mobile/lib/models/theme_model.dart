import 'package:flutter/material.dart';

enum AppThemeMode { light, dark, system }

enum AppColorScheme { blue, pink, purple, green, orange }

class ThemeModel {
  final AppThemeMode themeMode;
  final AppColorScheme colorScheme;

  const ThemeModel({
    this.themeMode = AppThemeMode.system,
    this.colorScheme = AppColorScheme.blue,
  });

  ThemeModel copyWith({AppThemeMode? themeMode, AppColorScheme? colorScheme}) {
    return ThemeModel(
      themeMode: themeMode ?? this.themeMode,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  Map<String, dynamic> toJson() {
    return {'themeMode': themeMode.name, 'colorScheme': colorScheme.name};
  }

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      themeMode: AppThemeMode.values.firstWhere(
        (e) => e.name == json['themeMode'],
        orElse: () => AppThemeMode.system,
      ),
      colorScheme: AppColorScheme.values.firstWhere(
        (e) => e.name == json['colorScheme'],
        orElse: () => AppColorScheme.blue,
      ),
    );
  }

  // Get MaterialApp theme mode
  ThemeMode get materialThemeMode {
    switch (themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  // Get color seed for theme
  Color get seedColor {
    switch (colorScheme) {
      case AppColorScheme.blue:
        return Colors.blue;
      case AppColorScheme.pink:
        return Colors.pink;
      case AppColorScheme.purple:
        return Colors.purple;
      case AppColorScheme.green:
        return Colors.green;
      case AppColorScheme.orange:
        return Colors.orange;
    }
  }

  // Get display name for color scheme
  String get colorSchemeName {
    switch (colorScheme) {
      case AppColorScheme.blue:
        return 'Blue';
      case AppColorScheme.pink:
        return 'Pink';
      case AppColorScheme.purple:
        return 'Purple';
      case AppColorScheme.green:
        return 'Green';
      case AppColorScheme.orange:
        return 'Orange';
    }
  }

  // Get display name for theme mode
  String get themeModeName {
    switch (themeMode) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System';
    }
  }
}
