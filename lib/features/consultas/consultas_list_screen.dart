import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/core/providers.dart';
import 'package:essence/features/consultas/consultas_provider.dart';
import 'package:essence/features/consultas/consulta_edit_screen.dart';
import 'package:essence/features/results/results_screen.dart';

class ConsultasListScreen extends ConsumerStatefulWidget {
  const ConsultasListScreen({super.key});

  @override
  ConsumerState<ConsultasListScreen> createState() =>
      _ConsultasListScreenState();
}

class _ConsultasListScreenState extends ConsumerState<ConsultasListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(consultasProvider.notifier).carregar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(consultasProvider);

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
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Text('Minhas Consultas',
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: state.consultas.isEmpty
                      ? Center(
                          child: Text('Nenhuma consulta ainda.',
                              style: Theme.of(context).textTheme.bodyMedium))
                      : ListView.builder(
                          itemCount: state.consultas.length,
                          itemBuilder: (context, index) {
                            final consulta = state.consultas[index];
                            final dataFormatada = DateFormat('dd/MM/yy – HH:mm')
                                .format(consulta.data);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.04),
                                  borderRadius: BorderRadius.circular(24),
                                  border:
                                      Border.all(color: AppTheme.glassBorder),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(dataFormatada,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: AppTheme.primary,
                                                  size: 20),
                                              onPressed: () =>
                                                  _editar(consulta),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.redAccent,
                                                  size: 20),
                                              onPressed: () =>
                                                  _confirmarExclusao(
                                                      consulta.id!),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${consulta.emocao} · ${consulta.lugar} · ${consulta.elemento} · ${consulta.cor}',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${consulta.resultadoIds.length} perfumes recomendados',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          _verResultados(consulta.resultadoIds),
                                      child: const Text('Ver recomendação'),
                                    ),
                                  ],
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

  void _editar(consulta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConsultaEditScreen(consulta: consulta),
      ),
    );
  }

  void _confirmarExclusao(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        title: const Text('Excluir consulta?',
            style: TextStyle(color: AppTheme.textPrimary)),
        content: const Text('Essa ação não pode ser desfeita.',
            style: TextStyle(color: AppTheme.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref.read(consultasProvider.notifier).excluir(id);
              Navigator.pop(ctx);
            },
            child: const Text('Excluir',
                style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  void _verResultados(List<String> ids) {
    final repo = ref.read(perfumeRepositoryProvider);
    final perfumes = ids.map((id) => repo.getById(id)!).toList();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultsScreen(perfumes: perfumes)),
    );
  }
}
