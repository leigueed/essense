import 'package:flutter/material.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/data/models/perfume.dart';
import 'package:essence/shared/widgets/glass_card.dart';

class DetailScreen extends StatelessWidget {
  final Perfume perfume;
  const DetailScreen({super.key, required this.perfume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.2,
            colors: [
              Color(int.parse('0xFF${perfume.corHex.substring(1)}'))
                  .withValues(alpha: 0.3),
              AppTheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon:
                      const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                Text(perfume.nome,
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 8),
                Text(perfume.marca,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 24),
                GlassCard(
                  borderRadius: 24,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      perfume.frasePoetica,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text('Pirâmide Olfativa',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                _NoteSection(
                    title: 'Notas de Topo', content: perfume.notasTopo),
                _NoteSection(
                    title: 'Notas de Coração', content: perfume.notasCoracao),
                _NoteSection(
                    title: 'Notas de Fundo', content: perfume.notasFundo),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NoteSection extends StatelessWidget {
  final String title;
  final String content;
  const _NoteSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppTheme.textSecondary)),
          const SizedBox(height: 4),
          Text(content, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
