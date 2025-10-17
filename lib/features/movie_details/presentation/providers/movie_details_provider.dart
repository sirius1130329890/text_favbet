import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/core/api/entities/movie.dart';
import 'package:test_favbet/core/api/entities/movie_details.dart';
import 'package:test_favbet/core/api/repositories/movies.dart';
import 'package:test_favbet/features/home/presentation/providers/home_provider.dart';

//This is my first time with Riverdrop. Be kind.

class MovieDetailsNotifier extends AsyncNotifier<MovieDetailsEntity> {
  late final MoviesRepository _repository;
  late final String movieId;

  @override
  Future<MovieDetailsEntity> build() async {
    _repository = ref.read(moviesRepositoryProvider);
    return _repository.getMovieById(movieId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final movie = await _repository.getMovieById(movieId);
      state = AsyncData(movie);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
final movieDetailsProvider = FutureProvider.family<MovieDetailsEntity, String>((ref, movieId) async {
  final repository = ref.read(moviesRepositoryProvider);
  return repository.getMovieById(movieId);
});