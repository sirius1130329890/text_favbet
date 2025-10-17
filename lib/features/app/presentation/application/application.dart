import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_favbet/core/theme/theme_provider.dart';
import 'package:test_favbet/core/theme/themes/dark_theme.dart';

import '../../../../core/routes/provider.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(builder: (context, ref, _) {
        final theme = ref.watch(appThemeProvider);
        final router = ref.watch(routerProvider);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
            theme is DarkTheme ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: theme.bg,
          ));
        });

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: ThemeData(
            scaffoldBackgroundColor: theme.bg
          ),
        );
      }),
    );
  }
}