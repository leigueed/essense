import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/features/auth/auth_provider.dart';

class CadastroScreen extends ConsumerStatefulWidget {
  const CadastroScreen({super.key});

  @override
  ConsumerState<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends ConsumerState<CadastroScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  String? _erro;

  Future<void> _cadastrar() async {
    final erro = await ref.read(authProvider.notifier).cadastrar(
          _nomeController.text.trim(),
          _emailController.text.trim(),
          _senhaController.text,
        );
    if (erro != null) {
      setState(() => _erro = erro);
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

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
            padding: const EdgeInsets.fromLTRB(16, 22, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.textSecondary),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 22),
                    Text(
                      'Criar conta',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: const TextStyle(color: AppTheme.textSecondary),
                    prefixIcon:
                        const Icon(Icons.person, color: AppTheme.textSecondary),
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
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(_erro!,
                        style: const TextStyle(color: Colors.redAccent)),
                  ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.textSecondary,
                    foregroundColor: AppTheme.background,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
