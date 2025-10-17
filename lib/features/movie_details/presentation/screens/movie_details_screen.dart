import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/features/movie_details/presentation/components/body.dart';
import 'package:test_favbet/features/movie_details/presentation/providers/movie_details_provider.dart';
import 'package:test_favbet/shared/theme/theme_provider.dart';
import 'package:test_favbet/uikit/components/loader/animation.dart';

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetails = ref.watch(movieDetailsProvider(id));
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      body: movieDetails.when(
          data: (movie) => MovieDetailsBody(movie: movie,),
          loading: () => Center(child: AppLoader(color: theme.loader,)),
          error: (err, stack) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: $err'),
                ],
              ),
            );
          }
      ),
    );
  }
}
