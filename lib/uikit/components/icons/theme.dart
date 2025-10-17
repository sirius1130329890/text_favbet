import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/shared/theme/theme_provider.dart';
import 'package:test_favbet/shared/theme/themes/light_theme.dart';
import 'package:test_favbet/uikit/assets/icons/app_icons.dart';

class ThemeIcon extends ConsumerWidget {
  const ThemeIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    onTap() {
      HapticFeedback.selectionClick();
      ref.read(appThemeProvider.notifier).chanheTheme();
    }
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: theme is LightTheme ? 0 : 1),
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
              theme is LightTheme ? AppIcons.sun : AppIcons.moon,
              color: theme.txt,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
