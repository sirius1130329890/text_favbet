
import 'package:test_favbet/core/storage/shared_preferences_storage.dart';
import 'package:test_favbet/core/storage/storage_service.dart';

import 'favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final StorageService<List<String>> storage = SharedPreferencesStorage();
  List<int> _cache = [];
  static const _key = 'favorite_movie_ids';


  @override
  Future<List<int>> getFavorites() async {
    final storedList = await storage.get(_key, defaultValue: <String>[]);
    _cache = storedList?.map(int.parse).toList() ?? [];
    return _cache;
  }

  @override
  Future<void> toggleFavorite(int movieId) async {
    if (_cache.contains(movieId)) {
      _cache.remove(movieId);
    } else {
      _cache.add(movieId);
    }
    await storage.set(_key, _cache.map((e) => e.toString()).toList());
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    if (_cache.isEmpty) {
      await getFavorites();
    }
    return _cache.contains(movieId);
  }
}

