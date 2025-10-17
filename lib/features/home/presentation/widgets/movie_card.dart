import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/core/api/entities/movie.dart';
import 'package:test_favbet/core/routes/app_navigator.dart';
import 'package:test_favbet/shared/theme/fonts/fonts_provider.dart';
import 'package:test_favbet/uikit/components/icons/star.dart';
import 'package:test_favbet/uikit/components/images/network_image.dart';

class MovieCard extends ConsumerWidget {
  final MovieEntity movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fonts = ref.watch(appFontsProvider);
    void oneTap() {
      HapticFeedback.vibrate();
      AppNavigator.goMovieDetails(context, movie.id.toString());
    }
    return GestureDetector(
      onTap: oneTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 0.7,
                        child: NetworkImageCached(
                          movie.posterPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 11,
                        top: 11,
                        child: StarIcon(movie.id),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  movie.title+movie.title,
                  overflow: TextOverflow.ellipsis,
                  style: fonts.name,
                ),
                Text(
                  'Rating: ${movie.voteAverage.toStringAsFixed(1)}',
                  style: fonts.rating,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
