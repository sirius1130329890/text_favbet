abstract interface class FavoritesRepository {
  Future<List<int>> getFavorites();
  Future<void> toggleFavorite(int movieId);
  Future<bool> isFavorite(int movieId);
}
