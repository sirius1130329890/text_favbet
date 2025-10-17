import 'package:dio/dio.dart';

abstract interface class IApiClient {
  CancelToken get cancelToken;
}

class DioClient implements IApiClient {
  final Dio dio;

  static const String url = 'https://api.themoviedb.org/3/';
  static const String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MGZhMjRjYjJiOTY4NjU4NjZhYjQwOTI0MGNlZGIzNiIsIm5iZiI6MTc2MDM2MTY2OS43MzEsInN1YiI6IjY4ZWNmY2M1NTExN2I5NTE3MDVlZTc5MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9IKVvbrvxDshmS1xe7wJfZuzLqE7PSaz9MVc89DlSx8';

  @override
  CancelToken cancelToken = CancelToken();

  DioClient() : dio = Dio(
    BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  ) {
    dio.interceptors.add(LogInterceptor(requestBody: true));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          options.headers["Authorization"] = "Bearer $accessToken";
          return handler.next(options);
        },
      ),
    );
  }
}
