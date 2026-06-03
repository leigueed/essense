import 'package:flutter/material.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/data/models/perfume.dart';
import 'package:essence/shared/widgets/shimmer_reveal.dart';
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
          child: ShimmerReveal(
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
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      Text('Suas Essências',
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: perfumes.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final perfume = perfumes[index];
                        return PerfumeCard(perfume: perfume);
                      },
                    ),
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
