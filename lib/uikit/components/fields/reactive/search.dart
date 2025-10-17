import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/features/search/presentation/providers/search_movies_provider.dart';
import 'package:test_favbet/shared/theme/fonts/fonts_provider.dart';
import 'package:test_favbet/shared/theme/theme_provider.dart';
import 'package:test_favbet/uikit/assets/icons/app_icons.dart';

import 'reactive_field_override.dart';

class ReactiveSearchField extends ConsumerWidget {
  final String formControlName;

  const ReactiveSearchField({
    super.key,
    this.formControlName = 'search',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final notifier = ref.read(searchMoviesNotifierProvider.notifier);
    final fonts = ref.watch(appFontsProvider);

    return ReactiveTextFieldOverride<String>(
      formControlName: formControlName,
      style: fonts.search,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(AppIcons.search, color: fonts.txt,),
        filled: true,
        fillColor: theme.search,
        hintStyle: fonts.searchHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (control) {
        final query = control.value ?? '';
        notifier.search(query);
      },
    );
  }
}