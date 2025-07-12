import 'package:flutter/material.dart';
import '../services/theme_datastore.dart';
import '../models/theme_model.dart';

/// Demo class để hiển thị cách sử dụng DataStore cho theme
class ThemeDataStoreDemo {
  static final ThemeDataStore _dataStore = ThemeDataStore.instance;

  /// Demo: Lưu theme với Light mode và Blue color
  static Future<void> demoSaveLightBlueTheme() async {
    const theme = ThemeModel(
      themeMode: AppThemeMode.light,
      colorScheme: AppColorScheme.blue,
    );

    await _dataStore.saveTheme(theme);
    print('✅ Saved Light Blue theme to DataStore');
  }

  /// Demo: Lưu theme với Dark mode và Pink color
  static Future<void> demoSaveDarkPinkTheme() async {
    const theme = ThemeModel(
      themeMode: AppThemeMode.dark,
      colorScheme: AppColorScheme.pink,
    );

    await _dataStore.saveTheme(theme);
    print('✅ Saved Dark Pink theme to DataStore');
  }

  /// Demo: Lưu theme với System mode và Purple color
  static Future<void> demoSaveSystemPurpleTheme() async {
    const theme = ThemeModel(
      themeMode: AppThemeMode.system,
      colorScheme: AppColorScheme.purple,
    );

    await _dataStore.saveTheme(theme);
    print('✅ Saved System Purple theme to DataStore');
  }

  /// Demo: Tải theme từ DataStore
  static Future<ThemeModel> demoLoadTheme() async {
    final theme = await _dataStore.loadTheme();
    print(
      '📱 Loaded theme: ${theme.themeModeName} mode, ${theme.colorSchemeName} color',
    );
    return theme;
  }

  /// Demo: Kiểm tra xem có theme được lưu không
  static Future<void> demoCheckThemeExists() async {
    final hasTheme = await _dataStore.hasTheme();
    print('🔍 Theme exists in DataStore: $hasTheme');
  }

  /// Demo: Xóa theme khỏi DataStore
  static Future<void> demoClearTheme() async {
    await _dataStore.clearTheme();
    print('🗑️ Cleared theme from DataStore');
  }

  /// Demo: Test complete flow
  static Future<void> demoCompleteFlow() async {
    print('\n🚀 Starting DataStore Theme Demo...\n');

    // 1. Kiểm tra theme hiện tại
    await demoCheckThemeExists();

    // 2. Lưu một theme mới
    await demoSaveLightBlueTheme();

    // 3. Kiểm tra lại
    await demoCheckThemeExists();

    // 4. Tải theme
    await demoLoadTheme();

    // 5. Thay đổi theme
    await demoSaveDarkPinkTheme();

    // 6. Tải theme mới
    await demoLoadTheme();

    // 7. Test với System theme
    await demoSaveSystemPurpleTheme();

    // 8. Tải lần cuối
    final finalTheme = await demoLoadTheme();

    // 9. Hiển thị thông tin chi tiết
    print('\n📊 Final Theme Details:');
    print('   Theme Mode: ${finalTheme.themeModeName}');
    print('   Color Scheme: ${finalTheme.colorSchemeName}');
    print('   Seed Color: ${finalTheme.seedColor}');
    print('   Material Theme Mode: ${finalTheme.materialThemeMode}');

    // 10. Optional: Clear theme (uncomment để test)
    // await demoClearTheme();
    // await demoCheckThemeExists();

    print('\n✨ DataStore Theme Demo completed!\n');
  }
}

/// Extension để demo các thao tác theme
extension ThemeModelDemo on ThemeModel {
  /// Demo: Tạo theme copy với thay đổi mode
  ThemeModel demoChangeMode(AppThemeMode newMode) {
    print('🔄 Changing theme mode from ${themeModeName} to ${newMode.name}');
    return copyWith(themeMode: newMode);
  }

  /// Demo: Tạo theme copy với thay đổi color
  ThemeModel demoChangeColor(AppColorScheme newColor) {
    print(
      '🎨 Changing color scheme from ${colorSchemeName} to ${newColor.name}',
    );
    return copyWith(colorScheme: newColor);
  }

  /// Demo: Hiển thị thông tin theme
  void demoShowInfo() {
    print('ℹ️ Theme Info:');
    print('   Mode: $themeModeName');
    print('   Color: $colorSchemeName');
    print('   Seed: ${seedColor.toString()}');
  }
}

/// Demo widget để test theme trong UI
class ThemeDataStoreDemoWidget extends StatefulWidget {
  const ThemeDataStoreDemoWidget({super.key});

  @override
  State<ThemeDataStoreDemoWidget> createState() =>
      _ThemeDataStoreDemoWidgetState();
}

class _ThemeDataStoreDemoWidgetState extends State<ThemeDataStoreDemoWidget> {
  ThemeModel? _currentTheme;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    setState(() => _isLoading = true);

    try {
      final theme = await ThemeDataStore.instance.loadTheme();
      setState(() => _currentTheme = theme);
    } catch (e) {
      print('Error loading theme: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveRandomTheme() async {
    final modes = AppThemeMode.values;
    final colors = AppColorScheme.values;

    final randomTheme = ThemeModel(
      themeMode: modes[DateTime.now().millisecond % modes.length],
      colorScheme: colors[DateTime.now().microsecond % colors.length],
    );

    try {
      await ThemeDataStore.instance.saveTheme(randomTheme);
      await _loadTheme();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Saved ${randomTheme.themeModeName} ${randomTheme.colorSchemeName} theme',
            ),
          ),
        );
      }
    } catch (e) {
      print('Error saving theme: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DataStore Demo'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_currentTheme != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Current Theme from DataStore',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Text('Mode: ${_currentTheme!.themeModeName}'),
                        Text('Color: ${_currentTheme!.colorSchemeName}'),
                        const SizedBox(height: 16),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _currentTheme!.seedColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _saveRandomTheme,
                  child: const Text('Save Random Theme'),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () async {
                    await ThemeDataStoreDemo.demoCompleteFlow();
                  },
                  child: const Text('Run Console Demo'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
