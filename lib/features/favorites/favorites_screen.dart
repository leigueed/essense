import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/core/providers.dart';
import 'package:essence/features/favorites/favorites_provider.dart';
import 'package:essence/features/detail/detail_screen.dart';
import 'package:essence/shared/widgets/glass_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesProvider);
    final repo = ref.watch(perfumeRepositoryProvider);

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
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.textPrimary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    Text('Meu Jardim Olfativo',
                        style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(width: 8),
                    const Icon(Icons.local_florist,
                        color: AppTheme.primary, size: 24),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: favoritesState.favoritosIds.isEmpty
                      ? Center(
                          child: Text('Nenhum perfume favoritado ainda.',
                              style: Theme.of(context).textTheme.bodyMedium))
                      : ListView.builder(
                          itemCount: favoritesState.favoritosIds.length,
                          itemBuilder: (context, index) {
                            final perfumeId =
                                favoritesState.favoritosIds[index];
                            final perfume = repo.getById(perfumeId);
                            if (perfume == null) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          DetailScreen(perfume: perfume),
                                    ),
                                  );
                                },
                                child: GlassCard(
                                  borderRadius: 24,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                perfume.nome,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                perfume.frasePoetica,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: AppTheme.textSecondary,
                                              size: 20),
                                          onPressed: () => ref
                                              .read(favoritesProvider.notifier)
                                              .removeFavorite(perfumeId),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
