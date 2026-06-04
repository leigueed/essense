import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/data/models/perfume.dart';
import 'package:essence/features/detail/detail_screen.dart';
import 'package:essence/features/favorites/favorites_provider.dart';
import 'package:essence/shared/widgets/glass_card.dart';
import 'package:essence/shared/widgets/note_bar.dart';

class PerfumeCard extends ConsumerWidget {
  final Perfume perfume;

  const PerfumeCard({super.key, required this.perfume});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesProvider);
    favoritesState.favoritosIds.contains(perfume.id);

    return GlassCard(
      borderRadius: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(int.parse('0xFF${perfume.corHex.substring(1)}'))
                  .withValues(alpha: 1),
              Colors.transparent,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Linha superior: nome + coração
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      perfume.nome,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              // Marca
              Text(perfume.marca,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 15),
              // Frase poética
              Text(
                perfume.frasePoetica,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              // Pirâmide olfativa
              NoteBar(
                topNote: perfume.notasTopo,
                heartNote: perfume.notasCoracao,
                baseNote: perfume.notasFundo,
              ),
              const SizedBox(height: 15),
              // 🔘 BOTÃO "VER DETALHES"
              const SizedBox(height: 10),
              // Botão "Ver detalhes" centralizado e maior
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailScreen(perfume: perfume)),
                    );
                  },
                  icon: const Icon(Icons.info_outline,
                      color: AppTheme.primary, size: 18),
                  label: const Text(
                    'Ver detalhes',
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          color: AppTheme.primary.withValues(alpha: 0.5)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
