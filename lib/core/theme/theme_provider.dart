import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/core/storage/shared_preferences_storage.dart';
import 'package:test_favbet/core/storage/storage_service.dart';
import 'package:test_favbet/core/theme/theme_mode_enum.dart';
import 'package:test_favbet/core/theme/themes/dark_theme.dart';
import 'package:test_favbet/core/theme/themes/light_theme.dart';

import 'app_theme.dart';

const _themeKey = 'app_theme_mode';

//This is my first time with Riverdrop. Be kind.

final appThemeProvider =
NotifierProvider<AppThemeNotifier, AppTheme>(() => AppThemeNotifier());

class AppThemeNotifier extends Notifier<AppTheme> {
  AppThemeMode _currentMode = AppThemeMode.system;

  AppThemeMode get currentMode => _currentMode;
  StorageService storage = SharedPreferencesStorage();

  @override
  AppTheme build() {
    _init();
    return _resolveTheme();
  }

  Future<void> _init() async {
    final saved = await storage.get(_themeKey);
    _currentMode = AppThemeModeX.fromKey(saved);

    state = _resolveTheme();
  }

  AppTheme _resolveTheme() {
    switch (_currentMode) {
      case AppThemeMode.dark:
        return DarkTheme();
      case AppThemeMode.light:
        return LightTheme();
      case AppThemeMode.system:
        final brightness = WidgetsBinding.instance.window.platformBrightness;
        return brightness == Brightness.dark ? DarkTheme() : LightTheme();
    }
  }

  Future<void> setTheme(AppThemeMode mode) async {
    _currentMode = mode;
    await storage.set(_themeKey, mode.key);

    state = _resolveTheme();
  }

  Future<void> chanheTheme() async {
    if(currentMode == AppThemeMode.light){
      setTheme(AppThemeMode.dark);
    } else{
      setTheme(AppThemeMode.light);
    }
  }

}
