import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/data/database_helper.dart';
import 'package:essence/data/models/consulta.dart';
import 'package:essence/features/auth/auth_provider.dart';

class ConsultasState {
  final List<Consulta> consultas;
  final bool carregando;

  ConsultasState({this.consultas = const [], this.carregando = false});
}

class ConsultasNotifier extends StateNotifier<ConsultasState> {
  final DatabaseHelper _db = DatabaseHelper();
  final int? usuarioId;

  ConsultasNotifier(this.usuarioId) : super(ConsultasState());

  Future<void> carregar() async {
    if (usuarioId == null) return;
    state = ConsultasState(carregando: true);
    final maps = await _db.listarConsultas(usuarioId!);
    final consultas = maps.map((map) => Consulta.fromMap(map)).toList();
    state = ConsultasState(consultas: consultas);
  }

  Future<void> adicionar(String emocao, String lugar, String elemento,
      String cor, List<String> resultadoIds) async {
    if (usuarioId == null) return;
    final json = resultadoIds.join(',');
    await _db.inserirConsulta(usuarioId!, emocao, lugar, elemento, cor, json);
    await carregar();
  }

  Future<void> atualizar(int id, String emocao, String lugar, String elemento,
      String cor, List<String> resultadoIds) async {
    final json = resultadoIds.join(',');
    await _db.atualizarConsulta(id, emocao, lugar, elemento, cor, json);
    await carregar();
  }

  Future<void> excluir(int id) async {
    await _db.excluirConsulta(id);
    await carregar();
  }
}

final consultasProvider =
    StateNotifierProvider<ConsultasNotifier, ConsultasState>((ref) {
  final usuario = ref.watch(authProvider).usuario;
  return ConsultasNotifier(usuario?.id);
});
