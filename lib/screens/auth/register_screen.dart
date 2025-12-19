//C:\dev\task_manager\lib\screens\auth\register_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créer un compte')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _loading ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: const CircularProgressIndicator(),
            ),
            if (!_loading)
              ElevatedButton(
                child: const Text('Créer le compte'),
                onPressed: () async {
                  setState(() => _loading = true);
                  try {
                    await context.read<AuthProvider>().signUp(
                          _emailController.text,
                          _passwordController.text,
                        );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                  setState(() => _loading = false);
                },
              ),
          ],
        ),
      ),
    );
  }
}
