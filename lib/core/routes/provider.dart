import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_favbet/core/routes/routes.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/movie_details/presentation/screens/movie_details_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(path: AppRoutes.home, builder: (c, s) => HomeScreen()),
      GoRoute(path: AppRoutes.movieDetails, builder: (c, s) => MovieDetailsScreen(id: s.pathParameters['id']!,)),
      GoRoute(path: AppRoutes.search, builder: (c, s) => SearchScreen()),
    ],
  );
});