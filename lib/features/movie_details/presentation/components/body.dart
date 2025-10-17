import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_favbet/core/api/entities/movie_details.dart';
import 'package:test_favbet/core/theme/fonts/fonts_provider.dart';
import 'package:test_favbet/core/theme/theme_provider.dart';
import 'package:test_favbet/features/movie_details/presentation/widgets/favorite_button.dart';
import 'package:test_favbet/uikit/components/fields/formatters/release_date.dart';
import 'package:test_favbet/uikit/components/images/network_image.dart';
import 'package:test_favbet/uikit/layout_components/gap.dart';

class MovieDetailsBody extends ConsumerWidget {
  final MovieDetailsEntity movie;

  const MovieDetailsBody({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fonts = ref.watch(appFontsProvider);
    final theme = ref.watch(appThemeProvider);
    void onTapBack() {
      HapticFeedback.vibrate();
      context.pop();
    }
    return Padding(
      padding: Pad(horizontal: 16),
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: Pad(top: 73, bottom: 24),
                child: Row(
                  spacing: 24,
                  children: [
                    GestureDetector(
                      onTap: onTapBack,
                      behavior: HitTestBehavior.translucent,
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: theme.txt, size: 24,
                      ),
                    ),
                    Expanded(child: Text(movie.title, style: fonts.title, overflow: TextOverflow.ellipsis,)),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: SizedBox(
                  height: 377,
                  width: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: NetworkImageCached(
                      movie.posterPath,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Gap.v8,
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Rating: ${movie.voteAverage.toStringAsFixed(1)}',
                      style: fonts.rating,
                    ),
                  ),
                  Gap.v16,
                  Text(
                    movie.overview,
                    style: fonts.rating,
                  ),
                  Gap.v16,
                  Text(
                    formatReleaseDate(movie.releaseDate),
                    style: fonts.rating,
                  ),
                  Gap.v16,
                  FavoriteButton(int.parse(movie.id.toString())),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}