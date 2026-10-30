import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/di/injection_container.dart';

void main() async {
  // 1. Pastikan binding native Flutter sudah terinisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Muat variabel lingkungan dari file .env
  await dotenv.load(fileName: ".env");

  // 3. Inisialisasi Service Locator (GetIt) & seluruh dependensi
  await initDependencies();

  // 4. Jalankan aplikasi utama
  runApp(const MyApp());
}