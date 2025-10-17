import 'dart:ui';
import 'package:test_favbet/core/theme/colors.dart';

import '../app_theme.dart';

class LightTheme implements AppTheme {
  @override
  Color get bg => AppColors.white;

  @override
  Color get btn_bg1 => AppColors.maize;

  @override
  Color get btn_bg2 => AppColors.black;

  @override
  Color get btn_txt1 => AppColors.black;

  @override
  Color get btn_txt2 => AppColors.black;

  @override
  Color get favorite => AppColors.maize;

  @override
  Color get search => AppColors.matteWhite;

  @override
  Color get star => AppColors.white60;

  @override
  Color get title => AppColors.white;

  @override
  Color get txt => AppColors.black;

  @override
  Color get searchTxt => AppColors.black20;

  @override
  Color get loader => AppColors.black60;
}
