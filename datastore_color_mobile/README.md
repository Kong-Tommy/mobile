# DataStore Color Mobile

Ứng dụng Flutter demo sử dụng DataStore (SharedPreferences) để lưu trữ cài đặt theme của giao diện.

## Tính năng

- **Lưu trữ Theme**: Sử dụng SharedPreferences để lưu cài đặt theme
- **Theme Modes**: Hỗ trợ Light, Dark, và System theme
- **Color Schemes**: 5 bộ màu khác nhau (Blue, Pink, Purple, Green, Orange)
- **Persistent Settings**: Cài đặt được lưu và khôi phục khi khởi động lại app
- **State Management**: Sử dụng Provider pattern để quản lý state

## Cấu trúc dự án

```
lib/
├── main.dart                     # Entry point của app
├── models/
│   └── theme_model.dart         # Model cho theme data
├── providers/
│   └── theme_provider.dart      # Provider quản lý theme state
├── services/
│   └── theme_datastore.dart     # Service xử lý DataStore operations
└── screens/
    ├── home_screen.dart         # Màn hình chính
    ├── settings_screen.dart     # Màn hình cài đặt theme
    └── theme_detail_screen.dart # Màn hình chi tiết theme
```

## Cách hoạt động

### 1. Theme Model

`ThemeModel` định nghĩa:

- `AppThemeMode`: Light, Dark, System
- `AppColorScheme`: Blue, Pink, Purple, Green, Orange
- Phương thức serialize/deserialize JSON

### 2. DataStore Service

`ThemeDataStore` xử lý:

- Lưu theme vào SharedPreferences dưới dạng JSON
- Tải theme từ SharedPreferences
- Xử lý lỗi và fallback về theme mặc định

### 3. Theme Provider

`ThemeProvider` quản lý:

- State của theme hiện tại
- Cập nhật theme và lưu vào DataStore
- Cung cấp ThemeData cho MaterialApp

### 4. UI Screens

- **Home Screen**: Hiển thị theme hiện tại và demo
- **Settings Screen**: Cho phép thay đổi theme mode và color scheme
- **Theme Detail Screen**: Hiển thị thông tin chi tiết về theme

## Cách sử dụng

1. **Thay đổi Theme Mode**:

   - Mở Settings (icon ⚙️ trên AppBar)
   - Chọn Light, Dark, hoặc System trong phần "Theme Mode"

2. **Thay đổi Color Scheme**:

   - Trong Settings, chọn màu trong phần "Color Scheme"
   - Nhấn "Apply" để áp dụng

3. **Xem chi tiết Theme**:

   - Trong Settings, nhấn "View Theme Details"
   - Xem thông tin DataStore và color demo

4. **Reset Theme**:
   - Trong Settings, nhấn "Reset to Default"
   - Confirm để reset về theme mặc định

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.2.2 # DataStore cho lưu trữ local
  provider: ^6.1.1 # State management
```

## Cài đặt và chạy

1. Clone hoặc download project
2. Chạy `flutter pub get` để cài đặt dependencies
3. Chạy `flutter run` để khởi động app

## DataStore Implementation

### Lưu Theme

```dart
Future<void> saveTheme(ThemeModel theme) async {
  final prefs = await SharedPreferences.getInstance();
  final themeJson = jsonEncode(theme.toJson());
  await prefs.setString(_themeKey, themeJson);
}
```

### Tải Theme

```dart
Future<ThemeModel> loadTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final themeJson = prefs.getString(_themeKey);

  if (themeJson != null) {
    final themeMap = jsonDecode(themeJson) as Map<String, dynamic>;
    return ThemeModel.fromJson(themeMap);
  }

  return const ThemeModel(); // Default theme
}
```

## Tính năng nổi bật

- ✅ Auto-save theme settings
- ✅ Persistent across app restarts
- ✅ Error handling với fallback
- ✅ Material 3 design
- ✅ Responsive UI
- ✅ Clean architecture pattern

## Screenshots

App hiển thị các màn hình tương tự như design trong attachment, với:

- Home screen với theme info
- Settings screen với theme/color options
- Theme detail screen với DataStore info

## Phát triển thêm

Có thể mở rộng:

- Thêm custom color picker
- Lưu trữ font preferences
- Theme animation transitions
- Export/import theme settings
