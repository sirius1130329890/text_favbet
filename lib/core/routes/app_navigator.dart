import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_favbet/core/routes/routes.dart';

class AppNavigator {
  const AppNavigator._();

  static void goHome(BuildContext context) => context.push(AppRoutes.home);
  static void goMovieDetails(BuildContext context, String id) =>
      context.push(AppRoutes.movieDetails.replaceAll(':id', id));
  static void goSearch(BuildContext context) => context.push(AppRoutes.search);
}