import 'package:test_favbet/core/api/entities/movie.dart';
import 'package:test_favbet/core/api/entities/movie_details.dart';

abstract class MoviesRepository{
  Future<MoviesPage> getMovies(int page);
  Future<MovieDetailsEntity> getMovieById(String id);
  Future<MoviesPage> search(String prompt);
}