import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:test_favbet/core/api/datasources/movies.dart';
import 'package:test_favbet/core/api/entities/movie.dart';
import 'package:test_favbet/core/api/repositories/movies.dart';

//This is my first time with Riverdrop. Be kind.

class MoviesNotifier extends AsyncNotifier<List<MovieEntity>> {
  late final MoviesRepository _repository;
  int _currentPage = 1;
  bool _hasMore = true;

  @override
  Future<List<MovieEntity>> build() async {
    _repository = ref.watch(moviesRepositoryProvider);
    return _fetchPage(1, reset: true);
  }

  Future<List<MovieEntity>> _fetchPage(int page, {bool reset = false}) async {
    try {
      final moviesPage = await _repository.getMovies(page);
      ref.read(totalPagesProvider.notifier).state = min(moviesPage.total, 500);
      if (moviesPage.movies.isEmpty) _hasMore = false;
      if (reset) {
        _currentPage = page;
        return moviesPage.movies;
      }
      final currentList = state.value ?? [];
      _currentPage = page;
      return [...currentList, ...moviesPage.movies];
    } catch (e, st) {
      throw Exception('Unable to download movies: $e');
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(1, reset: true));
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !_hasMore) return;

    final nextPage = _currentPage + 1;
    state = await AsyncValue.guard(() => _fetchPage(nextPage));
  }

  Future<void> goToPage(int page) async {
    if (state.isLoading) return;
    _hasMore = true;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(page, reset: true));
  }
}

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  return MoviesRepositoryImpl();
});

final moviesNotifierProvider =
AsyncNotifierProvider<MoviesNotifier, List<MovieEntity>>(() {
  return MoviesNotifier();
});

final currentPageProvider = StateProvider<int>((ref) => 1);
final totalPagesProvider = StateProvider<int>((ref) => 19);