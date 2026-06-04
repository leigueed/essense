import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/features/auth/auth_provider.dart';
import 'package:essence/features/auth/cadastro_screen.dart';
import 'package:essence/features/home/home_screen.dart';

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
                // Título "Essence" em textSecondary
                Text(
                  'Essence!',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),
                const SizedBox(height: 8),
                // Subtítulo em textSecondary
                Text(
                  'Descubra a sua essência de perfume',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),
                const SizedBox(height: 40),
                // Campo de email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: AppTheme.textSecondary),
                    prefixIcon: const Icon(Icons.email_outlined,
                        color: AppTheme.textSecondary),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.textSecondary.withValues(alpha: 0.4)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primary),
                    ),
                  ),
                  style: const TextStyle(color: AppTheme.textPrimary),
                ),
                const SizedBox(height: 20),
                // Campo de senha
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: const TextStyle(color: AppTheme.textSecondary),
                    prefixIcon: const Icon(Icons.lock_outline,
                        color: AppTheme.textSecondary),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.textSecondary.withValues(alpha: 0.4)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primary),
                    ),
                  ),
                  style: const TextStyle(color: AppTheme.textPrimary),
                ),
                if (_erro != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(_erro!,
                        style: const TextStyle(color: Colors.redAccent)),
                  ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.textSecondary,
                    foregroundColor: AppTheme.background,
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
                  child: const Text(
                    'Criar uma conta',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
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
