import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/core/theme/theme_provider.dart';

import 'app_fonts.dart';

final appFontsProvider = Provider<AppFonts>((ref) {
  final theme = ref.watch(appThemeProvider);
  return AppFonts(
    txt: theme.txt,
    btnTxt2: theme.btn_txt2,
    searchTxt: theme.searchTxt,
    btnTxt1: theme.btn_txt1,
  );
});