import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/core/constants.dart';
import 'package:essence/core/providers.dart';
import 'package:essence/data/models/consulta.dart';
import 'package:essence/features/consultas/consultas_provider.dart';
import 'package:essence/shared/widgets/glass_card.dart';

class ConsultaEditScreen extends ConsumerStatefulWidget {
  final Consulta consulta;

  const ConsultaEditScreen({super.key, required this.consulta});

  @override
  ConsumerState<ConsultaEditScreen> createState() => _ConsultaEditScreenState();
}

class _ConsultaEditScreenState extends ConsumerState<ConsultaEditScreen> {
  final PageController _pageController = PageController();
  final List<String> _perguntasOrdem = ['emocao', 'lugar', 'elemento', 'cor'];
  int _currentPage = 0;

  late String _emocao;
  late String _lugar;
  late String _elemento;
  late String _cor;

  @override
  void initState() {
    super.initState();
    _emocao = widget.consulta.emocao;
    _lugar = widget.consulta.lugar;
    _elemento = widget.consulta.elemento;
    _cor = widget.consulta.cor;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _avancar(String pergunta, String resposta) {
    setState(() {
      switch (pergunta) {
        case 'emocao':
          _emocao = resposta;
          break;
        case 'lugar':
          _lugar = resposta;
          break;
        case 'elemento':
          _elemento = resposta;
          break;
        case 'cor':
          _cor = resposta;
          break;
      }
    });

    if (_currentPage < _perguntasOrdem.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _salvar();
    }
  }

  void _salvar() async {
    final tags = [_emocao, _lugar, _elemento, _cor];
    final repo = ref.read(perfumeRepositoryProvider);
    final recomendados = repo.recommend(tags);
    final ids = recomendados.map((p) => p.id).toList();

    await ref.read(consultasProvider.notifier).atualizar(
          widget.consulta.id!,
          _emocao,
          _lugar,
          _elemento,
          _cor,
          ids,
        );

    if (mounted) {
      Navigator.of(context)
        ..pop()
        ..pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Consulta atualizada com sucesso!'),
          backgroundColor: AppTheme.textPrimary,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.5,
            colors: [AppTheme.surface, AppTheme.background],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.textPrimary),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text('Editar Consulta',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    Text(
                      '${_currentPage + 1}/${_perguntasOrdem.length}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                LinearProgressIndicator(
                  value: (_currentPage + 1) / _perguntasOrdem.length,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppTheme.surface),
                  minHeight: 2,
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _perguntasOrdem.length,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    itemBuilder: (context, index) {
                      final pergunta = _perguntasOrdem[index];
                      return _PaginaPergunta(
                        pergunta: pergunta,
                        respostaAtual: _getRespostaAtual(pergunta),
                        onSelected: (res) => _avancar(pergunta, res),
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

  String _getRespostaAtual(String pergunta) {
    switch (pergunta) {
      case 'emocao':
        return _emocao;
      case 'lugar':
        return _lugar;
      case 'elemento':
        return _elemento;
      case 'cor':
        return _cor;
      default:
        return '';
    }
  }
}

class _PaginaPergunta extends StatelessWidget {
  final String pergunta;
  final String respostaAtual;
  final ValueChanged<String> onSelected;

  const _PaginaPergunta({
    required this.pergunta,
    required this.respostaAtual,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final opcoes = pergunta == 'emocao'
        ? AppConstants.emocoes
        : AppConstants.perguntas[pergunta]!;

    final textoPergunta = {
      'emocao': 'Como você quer\nse sentir hoje?',
      'lugar': 'Qual lugar\ncombina com esse sentimento?',
      'elemento': 'Qual elemento\nte veste melhor?',
      'cor': 'Uma cor que\ntraduz esse momento?',
    }[pergunta]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(textoPergunta, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 15),
        Text(
          'Atual: "$respostaAtual"',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppTheme.textPrimary),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView.separated(
            itemCount: opcoes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              final opcao = opcoes[index];
              final isSelecionada = opcao == respostaAtual;
              final iconData = AppConstants.getIcon(opcao);

              return GestureDetector(
                onTap: () => onSelected(opcao),
                child: GlassCard(
                  borderRadius: 20,
                  child: Container(
                    decoration: isSelecionada
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppTheme.primary.withValues(alpha: 0.2),
                                width: 1),
                          )
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          Icon(
                            iconData,
                            color: isSelecionada
                                ? AppTheme.surface
                                : AppTheme.textSecondary,
                            size: 28,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              opcao,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: isSelecionada
                                        ? AppTheme.surface
                                        : AppTheme.textPrimary,
                                    fontWeight: isSelecionada
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                            ),
                          ),
                          if (isSelecionada)
                            const Icon(Icons.check_circle,
                                color: AppTheme.surface, size: 24),
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
    );
  }
}
