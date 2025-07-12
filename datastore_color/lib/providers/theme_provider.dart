import 'package:flutter/material.dart';
import '../models/theme_model.dart';
import '../services/theme_datastore.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel _theme = const ThemeModel();
  bool _isLoading = true;

  ThemeModel get theme => _theme;
  bool get isLoading => _isLoading;

  ThemeProvider() {
    _loadTheme();
  }

  /// Load theme từ DataStore
  Future<void> _loadTheme() async {
    try {
      _isLoading = true;
      notifyListeners();

      final savedTheme = await ThemeDataStore.instance.loadTheme();
      _theme = savedTheme;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error loading theme: $e');
    }
  }

  /// Cập nhật theme mode (Light/Dark/System)
  Future<void> updateThemeMode(AppThemeMode themeMode) async {
    try {
      final newTheme = _theme.copyWith(themeMode: themeMode);
      await ThemeDataStore.instance.saveTheme(newTheme);
      _theme = newTheme;
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating theme mode: $e');
    }
  }

  /// Cập nhật color scheme
  Future<void> updateColorScheme(AppColorScheme colorScheme) async {
    try {
      final newTheme = _theme.copyWith(colorScheme: colorScheme);
      await ThemeDataStore.instance.saveTheme(newTheme);
      _theme = newTheme;
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating color scheme: $e');
    }
  }

  /// Cập nhật cả theme mode và color scheme cùng lúc
  Future<void> updateTheme({
    AppThemeMode? themeMode,
    AppColorScheme? colorScheme,
  }) async {
    try {
      final newTheme = _theme.copyWith(
        themeMode: themeMode,
        colorScheme: colorScheme,
      );
      await ThemeDataStore.instance.saveTheme(newTheme);
      _theme = newTheme;
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating theme: $e');
    }
  }

  /// Reset theme về mặc định
  Future<void> resetTheme() async {
    try {
      await ThemeDataStore.instance.clearTheme();
      _theme = const ThemeModel();
      notifyListeners();
    } catch (e) {
      debugPrint('Error resetting theme: $e');
    }
  }

  /// Get light theme data
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _theme.seedColor,
        brightness: Brightness.light,
      ),
    );
  }

  /// Get dark theme data
  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _theme.seedColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
