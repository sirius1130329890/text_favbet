import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/shared/theme/fonts/fonts_provider.dart';
import 'package:test_favbet/shared/theme/theme_provider.dart';
import 'package:test_favbet/uikit/components/loader/animation.dart';

class SearchStatusText extends ConsumerWidget {
  final AsyncValue searchState;
  final int total;
  final String query;

  const SearchStatusText({
    super.key,
    required this.searchState,
    required this.total,
    required this.query,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fonts = ref.watch(appFontsProvider);
    final theme = ref.watch(appThemeProvider);
    if (searchState.isLoading) {
      return SliverFillRemaining(
          hasScrollBody: false, child: Center(child: AppLoader(color: theme.loader,)));
    }
    if (searchState.hasError) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text('Error: ${searchState.error}', style: fonts.description),
        ),
      );
    }
    if (query.trim().length < 3) return const SliverToBoxAdapter(child: SizedBox.shrink());
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Search results ($total)', style: fonts.result),
      ),
    );
  }
}
