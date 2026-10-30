import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../storage/local_database.dart';
import '../storage/preferences_service.dart';
import '../storage/secure_storage_service.dart';

/// 'sl' adalah singkatan dari Service Locator (GetIt instance global)
final sl = GetIt.instance;

/// Fungsi inisialisasi seluruh dependensi aplikasi saat bootstrap
Future<void> initDependencies() async {
  // ─────────────────────────────────────────────────────────────
  // 1. EXTERNAL LIBRARIES (Paket Pihak Ketiga)
  // ─────────────────────────────────────────────────────────────

  // SharedPreferences harus di-await karena bersifat asynchronous
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Secure Storage dengan enkripsi hardware Android Keystore
  // Cukup panggil tanpa parameter aOptions:
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<Dio>(() => Dio());

  // ─────────────────────────────────────────────────────────────
  // 2. CORE STORAGE SERVICES
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<PreferencesService>(
    () => PreferencesService(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(sl<FlutterSecureStorage>()),
  );

  sl.registerLazySingleton<LocalDatabase>(() => LocalDatabase());

  // ─────────────────────────────────────────────────────────────
  // 3. CORE NETWORK SERVICES
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  sl.registerLazySingleton<DioClient>(
    () => DioClient(
      dio: sl<Dio>(),
      secureStorage: sl<FlutterSecureStorage>(),
      onUnauthorized: () {
        // Nanti dihubungkan ke logout otomatis saat token expired
      },
    ),
  );

  // ─────────────────────────────────────────────────────────────
  // 4. FEATURES (Akan ditambahkan seiring pembuatan fitur baru)
  // ─────────────────────────────────────────────────────────────
}
