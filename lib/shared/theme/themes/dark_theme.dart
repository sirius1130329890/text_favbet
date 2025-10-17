import 'dart:ui';
import 'package:test_favbet/shared/theme/colors.dart';
import '../app_theme.dart';

class DarkTheme implements AppTheme {
  @override
  Color get bg => AppColors.black;

  @override
  Color get btn_bg1 => AppColors.maize;

  @override
  Color get btn_bg2 => AppColors.white;

  @override
  Color get btn_txt1 => AppColors.black;

  @override
  Color get btn_txt2 => AppColors.white;

  @override
  Color get favorite => AppColors.maize;

  @override
  Color get search => AppColors.dark;

  @override
  Color get star => AppColors.white60;

  @override
  Color get title => AppColors.white;

  @override
  Color get txt => AppColors.white;

  @override
  Color get searchTxt => AppColors.white20;

  @override
  Color get loader => AppColors.white60;
}
