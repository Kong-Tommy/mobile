import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/theme_model.dart';

class ThemeDataStore {
  static const String _themeKey = 'app_theme';

  static ThemeDataStore? _instance;
  static ThemeDataStore get instance => _instance ??= ThemeDataStore._();

  ThemeDataStore._();

  /// Lưu theme settings vào DataStore
  Future<void> saveTheme(ThemeModel theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeJson = jsonEncode(theme.toJson());
      await prefs.setString(_themeKey, themeJson);
    } catch (e) {
      throw Exception('Failed to save theme: $e');
    }
  }

  /// Lấy theme settings từ DataStore
  Future<ThemeModel> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeJson = prefs.getString(_themeKey);

      if (themeJson != null) {
        final themeMap = jsonDecode(themeJson) as Map<String, dynamic>;
        return ThemeModel.fromJson(themeMap);
      }

      // Trả về theme mặc định nếu chưa có data
      return const ThemeModel();
    } catch (e) {
      // Trả về theme mặc định nếu có lỗi
      return const ThemeModel();
    }
  }

  /// Xóa theme settings
  Future<void> clearTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_themeKey);
    } catch (e) {
      throw Exception('Failed to clear theme: $e');
    }
  }

  /// Kiểm tra xem có theme settings được lưu hay không
  Future<bool> hasTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_themeKey);
    } catch (e) {
      return false;
    }
  }
}
