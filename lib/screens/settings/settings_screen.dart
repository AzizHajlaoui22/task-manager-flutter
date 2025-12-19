//C:\dev\task_manager\lib\screens\settings\settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListTile(
        title: const Text('Mode sombre'),
        trailing: Switch(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme(value);
          },
        ),
      ),
    );
  }
}
