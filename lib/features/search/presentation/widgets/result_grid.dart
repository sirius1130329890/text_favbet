import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:test_favbet/features/home/presentation/widgets/movie_card.dart';
import 'package:test_favbet/uikit/assets/icons/app_icons.dart';

class SearchResultGrid extends ConsumerWidget {
  final AsyncValue searchState;
  final FormGroup form;

  const SearchResultGrid({super.key, required this.searchState, required this.form});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = searchState.value ?? [];
    final query = form.control('search').value ?? '';

    if (query.trim().length < 3) return const SliverToBoxAdapter(child: SizedBox.shrink());

    if (movies.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Icon(AppIcons.noFound, size: 120, color: Colors.grey),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.only(top: 24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.58,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final movie = movies[index];
            return MovieCard(movie: movie);
          },
          childCount: movies.length,
        ),
      ),
    );
  }
}
