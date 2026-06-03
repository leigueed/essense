import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/data/database_helper.dart';
import 'package:essence/features/auth/auth_provider.dart';

class FavoritesState {
  final List<String> favoritosIds;
  final bool carregando;

  FavoritesState({this.favoritosIds = const [], this.carregando = false});
}

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final DatabaseHelper _db = DatabaseHelper();
  final int? _usuarioId;

  FavoritesNotifier(this._usuarioId) : super(FavoritesState()) {
    carregar();
  }

  Future<void> carregar() async {
    if (_usuarioId == null) return;
    state = FavoritesState(carregando: true);
    final ids = await _db.listarFavoritos(_usuarioId!);
    state = FavoritesState(favoritosIds: ids);
  }

  Future<void> toggleFavorite(String perfumeId) async {
    if (_usuarioId == null) return;
    if (state.favoritosIds.contains(perfumeId)) {
      await _db.desfavoritar(_usuarioId!, perfumeId);
    } else {
      await _db.favoritar(_usuarioId!, perfumeId);
    }
    await carregar();
  }

  Future<void> removeFavorite(String perfumeId) async {
    if (_usuarioId == null) return;
    await _db.desfavoritar(_usuarioId!, perfumeId);
    await carregar();
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
  final usuario = ref.watch(authProvider).usuario;
  return FavoritesNotifier(usuario?.id);
});
