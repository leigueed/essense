import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/core/theme.dart';
import 'package:essence/core/constants.dart';
import 'package:essence/core/providers.dart';
import 'package:essence/features/consultas/consultas_provider.dart';
import 'package:essence/features/results/results_screen.dart';
import 'package:essence/shared/widgets/glass_card.dart';

class QuestionScreen extends ConsumerStatefulWidget {
  final int? consultaId;
  final String? emocaoInicial;
  final String? lugarInicial;
  final String? elementoInicial;
  final String? corInicial;

  const QuestionScreen({
    super.key,
    this.consultaId,
    this.emocaoInicial,
    this.lugarInicial,
    this.elementoInicial,
    this.corInicial,
  });

  @override
  ConsumerState<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends ConsumerState<QuestionScreen> {
  final PageController _pageController = PageController();
  final List<String> perguntasOrdem = ['emocao', 'lugar', 'elemento', 'cor'];
  int _currentPage = 0;
  final Map<String, String> _respostas = {};

  @override
  void initState() {
    super.initState();
    if (widget.emocaoInicial != null) {
      _respostas['emocao'] = widget.emocaoInicial!;
    }
    if (widget.lugarInicial != null) {
      _respostas['lugar'] = widget.lugarInicial!;
    }
    if (widget.elementoInicial != null) {
      _respostas['elemento'] = widget.elementoInicial!;
    }
    if (widget.corInicial != null) {
      _respostas['cor'] = widget.corInicial!;
    }
    if (_respostas.length == 4) _finalizar();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextQuestion(String pergunta, String resposta) {
    _respostas[pergunta] = resposta;
    if (_currentPage < perguntasOrdem.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finalizar();
    }
  }

  void _finalizar() {
    final repo = ref.read(perfumeRepositoryProvider);
    final tags = _respostas.values.toList();
    final recomendados = repo.recommend(tags);
    final ids = recomendados.map((p) => p.id).toList();

    if (widget.consultaId != null) {
      ref.read(consultasProvider.notifier).atualizar(
            widget.consultaId!,
            _respostas['emocao']!,
            _respostas['lugar']!,
            _respostas['elemento']!,
            _respostas['cor']!,
            ids,
          );
    } else {
      ref.read(consultasProvider.notifier).adicionar(
            _respostas['emocao']!,
            _respostas['lugar']!,
            _respostas['elemento']!,
            _respostas['cor']!,
            ids,
          );
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ResultsScreen(perfumes: recomendados)),
    );
  }

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
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (_currentPage + 1) / perguntasOrdem.length,
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                  minHeight: 2,
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: perguntasOrdem.length,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    itemBuilder: (context, index) {
                      final pergunta = perguntasOrdem[index];
                      return _QuestionPage(
                        pergunta: pergunta,
                        onSelected: (res) => _nextQuestion(pergunta, res),
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

class _QuestionPage extends StatelessWidget {
  final String pergunta;
  final ValueChanged<String> onSelected;

  const _QuestionPage({required this.pergunta, required this.onSelected});

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
        const SizedBox(height: 40),
        Expanded(
          child: ListView.separated(
            itemCount: opcoes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final opcao = opcoes[index];
              final iconData = AppConstants.getIcon(opcao);
              return GestureDetector(
                onTap: () => onSelected(opcao),
                child: GlassCard(
                  borderRadius: 24,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Icon(iconData, color: AppTheme.primary, size: 28),
                        const SizedBox(width: 20),
                        Text(opcao,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
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
