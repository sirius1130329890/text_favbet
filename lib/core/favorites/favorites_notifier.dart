import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'favorites_repository.dart';
import 'favorites_repository_impl.dart';

class FavoritesNotifier extends StateNotifier<Set<int>> {
  final FavoritesRepository repository;

  FavoritesNotifier(this.repository) : super({}) {
    _load();
  }

  Future<void> _load() async {
    final ids = await repository.getFavorites();
    state = ids.toSet();
  }

  Future<void> toggle(int id) async {
    await repository.toggleFavorite(id);
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state}..add(id);
    }
  }

  bool isFavorite(int id) => state.contains(id);
}

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl();
});

final favoritesNotifierProvider =
StateNotifierProvider<FavoritesNotifier, Set<int>>((ref) {
  return FavoritesNotifier(ref.watch(favoritesRepositoryProvider));
});
