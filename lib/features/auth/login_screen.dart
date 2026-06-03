import 'package:essence/core/theme.dart';
import 'package:essence/features/auth/auth_provider.dart';
import 'package:essence/features/auth/cadastro_screen.dart';
import 'package:essence/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  String? _erro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [AppTheme.surface, AppTheme.background],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Essence',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 8),
                Text('Descubra a sua essência de perfume!',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 48),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon:
                        Icon(Icons.email_outlined, color: AppTheme.primary),
                  ),
                  style: const TextStyle(color: AppTheme.textPrimary),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    prefixIcon:
                        Icon(Icons.lock_outline, color: AppTheme.primary),
                  ),
                  style: const TextStyle(color: AppTheme.textPrimary),
                ),
                if (_erro != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(_erro!,
                        style: const TextStyle(color: Colors.redAccent)),
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Entrar'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CadastroScreen())),
                  child: const Text('Criar uma conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    final erro = await ref
        .read(authProvider.notifier)
        .login(_emailController.text.trim(), _senhaController.text);
    if (erro != null) {
      setState(() => _erro = erro);
    } else {
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    }
  }
}
