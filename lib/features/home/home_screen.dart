import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/features/auth/auth_provider.dart';
import 'package:essence/features/auth/login_screen.dart';
import 'package:essence/features/questionnaire/question_screen.dart';
import 'package:essence/features/consultas/consultas_list_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(authProvider).usuario;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Olá, ${usuario?.nome ?? ''}',
                        style: Theme.of(context).textTheme.titleLarge),
                    IconButton(
                      icon: const Icon(Icons.logout, color: AppTheme.primary),
                      onPressed: () {
                        ref.read(authProvider.notifier).logout();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                _MenuCard(
                  icon: Icons.science,
                  titulo: 'Nova Consulta',
                  descricao: 'Responda ao questionário e descubra seu perfume',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const QuestionScreen())),
                ),
                const SizedBox(height: 16),
                _MenuCard(
                  icon: Icons.history,
                  titulo: 'Minhas Consultas',
                  descricao: 'Histórico de consultas e recomendações',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ConsultasListScreen())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String descricao;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.titulo,
    required this.descricao,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppTheme.glassBorder),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primary, size: 32),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text(descricao,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}
