  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import '../../providers/auth_provider.dart';
  import 'register_screen.dart';

  class LoginScreen extends StatefulWidget {
    const LoginScreen({super.key});

    @override
    State<LoginScreen> createState() => _LoginScreenState();
  }

  class _LoginScreenState extends State<LoginScreen> {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    bool _loading = false;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Connexion')),
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
              // APRÈS
              AnimatedOpacity(
                opacity: _loading ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: const CircularProgressIndicator(),
              ),
              if (!_loading)
                ElevatedButton(
                  child: const Text('Se connecter'),
                  onPressed: () async {
                    setState(() => _loading = true);
                    try {
                      await context.read<AuthProvider>().signIn(
                            _emailController.text,
                            _passwordController.text,
                          );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                    setState(() => _loading = false);
                  },
                ),
              TextButton(
                child: const Text('Créer un compte'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }
