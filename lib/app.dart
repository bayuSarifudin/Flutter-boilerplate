import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Super-I Mobile',
      debugShowCheckedModeBanner:
          false, // Hilangkan pita tulisan 'DEBUG' di pojok kanan atas
      theme: AppTheme.lightTheme, // Pasang Design System terpusat kita
      routerConfig: AppRouter.router, // Pasang GoRouter terpusat kita
    );
  }
}
