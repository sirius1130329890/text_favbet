import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/core/favorites/favorites_notifier.dart';
import 'package:test_favbet/core/theme/theme_provider.dart';
import 'package:test_favbet/uikit/assets/icons/app_icons.dart';

class StarIcon extends ConsumerWidget {
  const StarIcon(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesNotifierProvider);
    final theme = ref.watch(appThemeProvider);
    final isFavorite = favorites.contains(id);
    onTap() {
      HapticFeedback.selectionClick();
      ref.read(favoritesNotifierProvider.notifier).toggle(id);
    }
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: isFavorite ? 0 : 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        final rotation = value * 6.28;
        return Transform.rotate(
          angle: rotation,
          child: IconButton(
            onPressed: onTap,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(
              AppIcons.star,
              size: 20,
              color: isFavorite ? theme.favorite : theme.star,
            )
          ),
        );
      },
    );
  }
}
