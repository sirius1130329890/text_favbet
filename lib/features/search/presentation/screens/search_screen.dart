import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:test_favbet/features/search/presentation/widgets/result_grid.dart';
import 'package:test_favbet/features/search/presentation/providers/search_movies_provider.dart';
import 'package:test_favbet/features/search/presentation/widgets/status_text.dart';
import 'package:test_favbet/shared/theme/fonts/fonts_provider.dart';
import 'package:test_favbet/shared/theme/theme_provider.dart';
import 'package:test_favbet/uikit/components/fields/reactive/search.dart';
import 'package:test_favbet/uikit/layout_components/gap.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();
    form = FormGroup({'search': FormControl<String>(value: '')});
    form.control('search').valueChanges.listen((value) {
      ref.read(searchMoviesNotifierProvider.notifier).search(value ?? '');
    });
  }

  void onTapBack() {
    HapticFeedback.vibrate();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final fonts = ref.watch(appFontsProvider);
    final theme = ref.watch(appThemeProvider);
    final searchState = ref.watch(searchMoviesNotifierProvider);
    final total = ref.watch(totalResultsProvider);

    return Scaffold(
      body: ReactiveForm(
        formGroup: form,
        child: Padding(
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
                        GestureDetector(
                          onTap: onTapBack,
                          behavior: HitTestBehavior.translucent,
                          child: Icon(Icons.arrow_back_ios_rounded,
                              color: theme.txt, size: 24),
                        ),
                        Gap.h16,
                        Text('Search', style: fonts.title),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Pad(top: 16),
                    child: ReactiveSearchField(),
                  ),
                ),
                SearchStatusText(
                  searchState: searchState,
                  total: total,
                  query: form.control('search').value ?? '',
                ),
                SearchResultGrid(searchState: searchState, form: form),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
