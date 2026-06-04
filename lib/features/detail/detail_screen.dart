import 'package:flutter/material.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/data/models/perfume.dart';

class DetailScreen extends StatelessWidget {
  final Perfume perfume;
  const DetailScreen({super.key, required this.perfume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back,
                          size: 20, color: AppTheme.textSecondary),
                      const SizedBox(width: 22),
                      Text(
                        'Voltar',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                perfume.nome,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(height: 10),
              // Marca
              Text(
                perfume.marca,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              Text(
                'Pirâmide Olfativa',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(height: 15),
              // Notas
              _NoteSection(title: 'Notas de Topo', content: perfume.notasTopo),
              _NoteSection(
                  title: 'Notas de Coração', content: perfume.notasCoracao),
              _NoteSection(
                  title: 'Notas de Fundo', content: perfume.notasFundo),
            ],
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 15),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}
