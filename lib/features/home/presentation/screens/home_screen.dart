import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/features/home/presentation/components/body.dart';
import 'package:test_favbet/features/home/presentation/providers/home_provider.dart';
import 'package:test_favbet/shared/theme/theme_provider.dart';
import 'package:test_favbet/uikit/components/loader/animation.dart';
import 'package:test_favbet/uikit/layout_components/gap.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesState = ref.watch(moviesNotifierProvider);
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      body: moviesState.when(
          data: (movies) => MoviesBody(movies: movies),
        loading: () => Center(child: AppLoader(color: theme.loader,)),
        error: (err, stack) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Error: $err'),
                Gap.v8,
                ElevatedButton(
                  onPressed: () => ref.read(moviesNotifierProvider.notifier).refresh(),
                  child: const Text('Try again'),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}