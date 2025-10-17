import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/core/favorites/favorites_notifier.dart';
import 'package:test_favbet/core/theme/fonts/fonts_provider.dart';
import 'package:test_favbet/core/theme/theme_provider.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesNotifierProvider);
    final theme = ref.watch(appThemeProvider);
    final fonts = ref.watch(appFontsProvider);
    final isFavorite = favorites.contains(id);

    void onTap() {
      HapticFeedback.lightImpact();
      ref.read(favoritesNotifierProvider.notifier).toggle(id);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isFavorite ? theme.favorite : Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          width: isFavorite ? 0 : 1,
          color: theme.btn_bg2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
            child: Text(
              key: ValueKey(isFavorite),
              isFavorite ? 'Remove from favorites' : 'Add to favorites',
              style: isFavorite ? fonts.add : fonts.remove,
            ),
          ),
        ),
      ),
    );
  }
}
