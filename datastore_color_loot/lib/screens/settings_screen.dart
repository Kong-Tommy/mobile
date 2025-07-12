import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';
import '../providers/theme_provider.dart';
import 'theme_detail_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          if (themeProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Theme Mode'),
                const SizedBox(height: 8),
                _buildThemeModeCard(context, themeProvider),

                const SizedBox(height: 24),

                _buildSectionTitle('Color Scheme'),
                const SizedBox(height: 8),
                _buildColorSchemeCard(context, themeProvider),

                const SizedBox(height: 24),

                _buildResetButton(context, themeProvider),

                const SizedBox(height: 16),

                _buildDetailButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildThemeModeCard(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Choose the light theme, dark theme and personality of your app',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: AppThemeMode.values.map((mode) {
                final isSelected = themeProvider.theme.themeMode == mode;
                return _buildThemeModeOption(
                  context,
                  mode,
                  isSelected,
                  () => themeProvider.updateThemeMode(mode),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeModeOption(
    BuildContext context,
    AppThemeMode mode,
    bool isSelected,
    VoidCallback onTap,
  ) {
    Color getColorForMode() {
      switch (mode) {
        case AppThemeMode.light:
          return Colors.white;
        case AppThemeMode.dark:
          return Colors.black;
        case AppThemeMode.system:
          return Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]!
              : Colors.grey[300]!;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: getColorForMode(),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: mode == AppThemeMode.system
            ? Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildColorSchemeCard(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Choose the app color scheme',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: AppColorScheme.values.map((colorScheme) {
                final isSelected =
                    themeProvider.theme.colorScheme == colorScheme;
                return _buildColorOption(
                  context,
                  colorScheme,
                  isSelected,
                  () => themeProvider.updateColorScheme(colorScheme),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Apply current theme (just for demo)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Theme applied successfully!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Apply'),
              ),
            ),
          ],
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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: getColor(),
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: getColor().withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  Widget _buildResetButton(BuildContext context, ThemeProvider themeProvider) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Reset Theme'),
              content: const Text(
                'Are you sure you want to reset the theme to default settings?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    themeProvider.resetTheme();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Theme reset to default'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          );
        },
        child: const Text('Reset to Default'),
      ),
    );
  }

  Widget _buildDetailButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ThemeDetailScreen()),
          );
        },
        icon: const Icon(Icons.info_outline),
        label: const Text('View Theme Details'),
      ),
    );
  }
}
