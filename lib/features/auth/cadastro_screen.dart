import 'package:essence/core/theme.dart';
import 'package:essence/features/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      Navigator.pop(context);
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
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppTheme.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Criar conta',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 32),
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person, color: AppTheme.primary),
                  ),
                  style: const TextStyle(color: AppTheme.textPrimary),
                ),
                const SizedBox(height: 16),
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
                  onPressed: _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.black,
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
