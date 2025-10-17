import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/features/home/presentation/providers/home_provider.dart';
import 'package:test_favbet/shared/theme/fonts/fonts_provider.dart';
import 'package:test_favbet/shared/theme/theme_provider.dart';

class PaginationBar extends ConsumerWidget {
  final void Function(int page) onPageSelected;

  const PaginationBar({super.key, required this.onPageSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);
    final totalPages = ref.watch(totalPagesProvider);
    final fonts = ref.watch(appFontsProvider);
    final theme = ref.watch(appThemeProvider);

    List<int> getVisiblePages() {
      if (totalPages <= 5) {
        return List.generate(totalPages, (i) => i + 1);
      }

      if (currentPage < 3) {
        return [1, 2, 3, -1, totalPages];
      }

      if (currentPage > totalPages - 2) {
        return [1, -1, totalPages - 2, totalPages - 1, totalPages];
      }

      return [1, -1, currentPage - 1, currentPage, currentPage + 1, -1, totalPages];
    }

    final visiblePages = getVisiblePages();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: visiblePages.map((page) {
        if (page == -1) {
          return Padding(
            padding: Pad(horizontal: 4),
            child: Text(
              '...',
              style: fonts.remove,
            ),
          );
        }

        final isActive = page == currentPage;

        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            ref.read(currentPageProvider.notifier).state = page;
            onPageSelected(page);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: Pad(horizontal: 6),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? theme.btn_bg1: Colors.transparent,
              border: Border.all(color: !isActive ? theme.btn_bg2: Colors.transparent),
            ),
            alignment: Alignment.center,
            child: Text(
              '$page',
              style: isActive ? fonts.add : fonts.remove
            ),
          ),
        );
      }).toList(),
    );
  }
}
