import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:test_favbet/core/api/dio_client.dart';
import 'package:test_favbet/core/api/entities/movie.dart';
import 'package:test_favbet/core/api/entities/movie_details.dart';
import 'package:test_favbet/core/api/repositories/movies.dart';

class MoviesRepositoryImpl implements MoviesRepository{
  final DioClient dioClient = DioClient();

  @override
  Future<MoviesPage> getMovies(int page) async{
    try {
      final response = await dioClient.dio.get('discover/movie', cancelToken: dioClient.cancelToken, queryParameters: {"page": page});
      final movies = (response.data['results'] as List)
          .map((json) => MovieEntity.fromJson(json))
          .toList();

      final totalPages = response.data['total_pages'];

      return MoviesPage(movies: movies, total: totalPages);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        if (kDebugMode) {
          print("Request was cancelled ${e.message}");
        }
      }
      rethrow;
    }
  }

  @override
  Future<MovieDetailsEntity> getMovieById(String id) async{
    try {
      final response = await dioClient.dio.get('movie/$id', cancelToken: dioClient.cancelToken);
      return MovieDetailsEntity.fromJson(response.data);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        if (kDebugMode) {
          print("Request was cancelled ${e.message}");
        }
      }
      rethrow;
    }
  }

  @override
  Future<MoviesPage> search(String prompt) async{
    if (!dioClient.cancelToken.isCancelled) {
      dioClient.cancelToken.cancel('Previous search cancelled');
    }
    dioClient.cancelToken = CancelToken();
    try {
      final response = await dioClient.dio.get('search/movie', cancelToken: dioClient.cancelToken, queryParameters: {'query': prompt});
      final movies = (response.data['results'] as List)
          .map((json) => MovieEntity.fromJson(json))
          .toList();

      final totalPages = response.data['total_results'];

      return MoviesPage(movies: movies, total: totalPages);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        if (kDebugMode) {
          print("Request was cancelled ${e.message}");
        }
      }
      rethrow;
    }
  }
}
