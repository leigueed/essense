import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionnaireState {
  final Map<String, String> respostas;

  QuestionnaireState({Map<String, String>? respostas})
      : respostas = respostas ?? {};

  QuestionnaireState copyWith({Map<String, String>? respostas}) {
    return QuestionnaireState(
      respostas: respostas ?? Map.from(this.respostas),
    );
  }

  List<String> get selectedTags => respostas.values.toList();
}

class QuestionnaireNotifier extends StateNotifier<QuestionnaireState> {
  QuestionnaireNotifier() : super(QuestionnaireState());

  void addResposta(String pergunta, String resposta) {
    final newRespostas = Map<String, String>.from(state.respostas);
    newRespostas[pergunta] = resposta;
    state = state.copyWith(respostas: newRespostas);
  }

  void reset() {
    state = QuestionnaireState();
  }
}

final questionnaireProvider =
    StateNotifierProvider<QuestionnaireNotifier, QuestionnaireState>(
  (ref) => QuestionnaireNotifier(),
);
