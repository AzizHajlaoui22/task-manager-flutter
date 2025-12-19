//C:\dev\task_manager\lib\main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart'; // ⬅️ OBLIGATOIRE
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/task_provider.dart'; // ⬅️ AJOUT IMPORTANT
import 'screens/auth/auth_wrapper.dart';

Future<void> main() async {
  // 🔑 Obligatoire pour Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Initialisation Firebase (Web + Mobile)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()), // ⬅️ MANQUANT
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home: const AuthWrapper(),
        );
      },
    );
  }
}
