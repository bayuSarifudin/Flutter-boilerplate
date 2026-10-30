import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../di/injection_container.dart';
import '../storage/secure_storage_service.dart';
import 'route_constants.dart';

/// Konfigurasi navigasi global GoRouter.
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true, // Mencetak rute navigasi di terminal saat debug
    // ─────────────────────────────────────────────────────────────
    // LOGIKA ROUTE GUARD (Redirect Otomatis Berdasarkan Login)
    // ─────────────────────────────────────────────────────────────
    redirect: (BuildContext context, GoRouterState state) async {
      final secureStorage = sl<SecureStorageService>();
      final token = await secureStorage.getAccessToken();

      final bool isLoggedIn = token != null && token.isNotEmpty;
      final bool isGoingToLogin = state.matchedLocation == AppRoutes.login;
      final bool isGoingToSplash = state.matchedLocation == AppRoutes.splash;

      // 1. Jika masih di layar Splash, jangan redirect dulu (biarkan splash selesai)
      if (isGoingToSplash) return null;

      // 2. Jika belum login dan mencoba masuk ke halaman private, tendang ke Login
      if (!isLoggedIn && !isGoingToLogin) {
        return AppRoutes.login;
      }

      // 3. Jika sudah login dan mencoba buka halaman Login lagi, bawa ke Home
      if (isLoggedIn && isGoingToLogin) {
        return AppRoutes.home;
      }

      // 4. Lanjutkan perjalanan ke rute tujuan
      return null;
    },

    // ─────────────────────────────────────────────────────────────
    // DAFTAR RUTE HALAMAN
    // ─────────────────────────────────────────────────────────────
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
    ],

    // Halaman jika rute tidak ditemukan (404 Not Found)
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Halaman tidak ditemukan: ${state.uri}')),
    ),
  );
}
