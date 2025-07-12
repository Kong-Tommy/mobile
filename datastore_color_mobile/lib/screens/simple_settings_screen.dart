import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../models/theme_model.dart';

class SimpleSettingsScreen extends StatelessWidget {
  const SimpleSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
        ),
        title: const Text(
          'Setting',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          if (themeProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Description text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Choosing the light theme, dark theme and personality of your app',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 40),

                // Theme mode toggle (light/dark)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildThemeModeOption(
                      context,
                      AppThemeMode.light,
                      themeProvider.theme.themeMode == AppThemeMode.light,
                      () => themeProvider.updateThemeMode(AppThemeMode.light),
                    ),
                    _buildThemeModeOption(
                      context,
                      AppThemeMode.dark,
                      themeProvider.theme.themeMode == AppThemeMode.dark,
                      () => themeProvider.updateThemeMode(AppThemeMode.dark),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Color selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorOption(
                      context,
                      AppColorScheme.blue,
                      themeProvider.theme.colorScheme == AppColorScheme.blue,
                      () =>
                          themeProvider.updateColorScheme(AppColorScheme.blue),
                    ),
                    _buildColorOption(
                      context,
                      AppColorScheme.pink,
                      themeProvider.theme.colorScheme == AppColorScheme.pink,
                      () =>
                          themeProvider.updateColorScheme(AppColorScheme.pink),
                    ),
                    _buildColorOption(
                      context,
                      AppColorScheme.purple,
                      themeProvider.theme.colorScheme == AppColorScheme.purple,
                      () => themeProvider.updateColorScheme(
                        AppColorScheme.purple,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Apply button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to detail screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SimpleThemeDetailScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildThemeModeOption(
    BuildContext context,
    AppThemeMode themeMode,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          color: themeMode == AppThemeMode.light
              ? Colors.white
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.withOpacity(0.3),
            width: isSelected ? 3 : 1,
          ),
        ),
        child: Center(
          child: Icon(
            themeMode == AppThemeMode.light
                ? Icons.light_mode
                : Icons.dark_mode,
            color: themeMode == AppThemeMode.light
                ? Colors.black54
                : Colors.white70,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildColorOption(
    BuildContext context,
    AppColorScheme colorScheme,
    bool isSelected,
    VoidCallback onTap,
  ) {
    Color getColor() {
      switch (colorScheme) {
        case AppColorScheme.blue:
          return const Color(0xFF2196F3);
        case AppColorScheme.pink:
          return const Color(0xFFE91E63);
        case AppColorScheme.purple:
          return const Color(0xFF9C27B0);
        case AppColorScheme.green:
          return const Color(0xFF4CAF50);
        case AppColorScheme.orange:
          return const Color(0xFFFF9800);
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 3,
                )
              : null,
        ),
      ),
    );
  }
}

class SimpleThemeDetailScreen extends StatelessWidget {
  const SimpleThemeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Theme-Applied Detail',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Title
                Text(
                  'Dark',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 30),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Choosing the light theme, dark the tone\nand personality of your app, enhancing\nuser experience and representing your\nbrand identity.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const Spacer(flex: 3),

                // Back button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
