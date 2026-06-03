import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/data/database_helper.dart';
import 'package:essence/data/models/usuario.dart';

class AuthState {
  final Usuario? usuario;
  final bool carregando;

  AuthState({this.usuario, this.carregando = false});
}

class AuthNotifier extends StateNotifier<AuthState> {
  final DatabaseHelper _db = DatabaseHelper();

  AuthNotifier() : super(AuthState());

  Future<String?> cadastrar(String nome, String email, String senha) async {
    try {
      await _db.inserirUsuario(nome, email, senha);
      return null;
    } catch (e) {
      return 'Erro ao cadastrar, email já existe!';
    }
  }

  Future<String?> login(String email, String senha) async {
    final map = await _db.login(email, senha);
    if (map != null) {
      state = AuthState(usuario: Usuario.fromMap(map));
      return null;
    }
    return 'Email ou senha inválidos.';
  }

  void logout() {
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
