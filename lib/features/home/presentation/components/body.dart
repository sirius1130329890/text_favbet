import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_favbet/core/api/entities/movie.dart';
import 'package:test_favbet/core/api/entities/movie_details.dart';
import 'package:test_favbet/core/routes/app_navigator.dart';
import 'package:test_favbet/features/home/presentation/providers/home_provider.dart';
import 'package:test_favbet/features/home/presentation/widgets/movie_card.dart';
import 'package:test_favbet/features/home/presentation/widgets/pagination_bar.dart';
import 'package:test_favbet/core/theme/fonts/fonts_provider.dart';
import 'package:test_favbet/core/theme/theme_provider.dart';
import 'package:test_favbet/uikit/assets/icons/app_icons.dart';
import 'package:test_favbet/uikit/components/icons/theme.dart';
import 'package:test_favbet/uikit/layout_components/gap.dart';

class MoviesBody extends ConsumerWidget {
  final List<MovieEntity> movies;

  const MoviesBody({super.key, required this.movies});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fonts = ref.watch(appFontsProvider);
    final theme = ref.watch(appThemeProvider);
    void oneTap() {
      HapticFeedback.vibrate();
      AppNavigator.goSearch(context);
    }
    return Padding(
      padding: Pad(horizontal: 16),
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: Pad(top: 73),
                child: Row(
                  children: [
                    Text('Movie', style: fonts.title,),
                    Spacer(),
                    GestureDetector(
                      onTap: oneTap,
                      behavior: HitTestBehavior.translucent,
                      child: Icon(AppIcons.search, color: theme.txt, size: 24,),
                    ),
                    Gap.h24,
                    ThemeIcon(),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: Pad(top: 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.58,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return MovieCard(movie: movies[index]);
                  },
                  childCount: movies.length,
                ),
              ),
            ),
            SliverPadding(
              padding: Pad(bottom: 44, top: 16),
              sliver: SliverToBoxAdapter(
                child: PaginationBar(onPageSelected: (int page) { ref.watch(moviesNotifierProvider.notifier).goToPage(page); },),
              ),
            ),
          ],
        ),
      ),
    );
  }
}