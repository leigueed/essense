import 'package:flutter/material.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/data/models/perfume.dart';
import 'package:essence/shared/widgets/perfume_card.dart';

class ResultsScreen extends StatelessWidget {
  final List<Perfume> perfumes;
  const ResultsScreen({super.key, required this.perfumes});

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Suas Essências',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: perfumes.isEmpty
                      ? Center(
                          child: Text(
                            'Nenhum perfume encontrado.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppTheme.textSecondary),
                          ),
                        )
                      : ListView.builder(
                          itemCount: perfumes.length,
                          itemBuilder: (context, index) {
                            final perfume = perfumes[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: PerfumeCard(perfume: perfume),
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
