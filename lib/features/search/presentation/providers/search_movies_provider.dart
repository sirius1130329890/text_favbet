import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:test_favbet/core/api/datasources/movies.dart';
import 'package:test_favbet/core/api/entities/movie.dart';
import 'package:test_favbet/core/api/repositories/movies.dart';

//This is my first time with Riverdrop. Be kind.

final searchMoviesNotifierProvider =
NotifierProvider<SearchMoviesNotifier, AsyncValue<List<MovieEntity>>>(
  SearchMoviesNotifier.new,
);

final totalResultsProvider = StateProvider<int>((ref) => 0);

class SearchMoviesNotifier extends Notifier<AsyncValue<List<MovieEntity>>> {
  late final MoviesRepository _repository;
  Timer? _debounce;

  @override
  AsyncValue<List<MovieEntity>> build() {
    _repository = MoviesRepositoryImpl();
    return const AsyncData([]);
  }

  Future<void> search(String query) async {
    if (query.trim().length < 3) {
      _debounce?.cancel();
      state = const AsyncData([]);
      ref.read(totalResultsProvider.notifier).state = 0;
      return;
    }

    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      state = const AsyncLoading();
      try {
        final result = await _repository.search(query);
        ref.read(totalResultsProvider.notifier).state = result.total;
        state = AsyncData(result.movies);
      } catch (e, st) {
        state = AsyncError(e, st);
      }
    });
  }
}
