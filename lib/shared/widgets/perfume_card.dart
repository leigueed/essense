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
    final isFavorited = favoritesState.favoritosIds.contains(perfume.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailScreen(perfume: perfume)),
        );
      },
      child: SizedBox(
        width: 260,
        child: GlassCard(
          borderRadius: 24,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(int.parse('0xFF${perfume.corHex.substring(1)}'))
                      .withValues(alpha: 0.25),
                  Colors.transparent,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          perfume.nome,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(favoritesProvider.notifier)
                              .toggleFavorite(perfume.id);
                        },
                        child: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: isFavorited
                              ? AppTheme.primary
                              : AppTheme.textSecondary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(perfume.marca,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  Text(
                    perfume.frasePoetica,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: AppTheme.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(),
                  NoteBar(
                    topNote: perfume.notasTopo,
                    heartNote: perfume.notasCoracao,
                    baseNote: perfume.notasFundo,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
