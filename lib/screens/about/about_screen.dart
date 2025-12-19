//C:\dev\task_manager\lib\screens\about\about_screen.dart
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // ❗ PAS const ici
      appBar: AppBar(
        title: const Text('À propos'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Application de gestion de tâches réalisée avec Flutter et Firebase.',
        ),
      ),
    );
  }
}
