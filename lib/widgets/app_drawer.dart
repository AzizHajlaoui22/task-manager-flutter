//C:\dev\task_manager\lib\widgets\app_drawer.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/about/about_screen.dart';
//import '../screens/api/quotes_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 20),
            ),
          ),

          // À propos
          ListTile(
            title: const Text('À propos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AboutScreen(),
                ),
              );
            },
          ),

          // Déconnexion
          ListTile(
            title: const Text('Déconnexion'),
            onTap: () {
              context.read<AuthProvider>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
