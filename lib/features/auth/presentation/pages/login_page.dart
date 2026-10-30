import 'package:flutter/material.dart';

import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nipController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nipController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_nipController.text.isEmpty || _passwordController.text.isEmpty) {
      AppSnackbar.showWarning(context, 'NIP dan Password tidak boleh kosong!');
      return;
    }

    setState(() => _isLoading = true);

    // Simulasi pengetesan tombol loading
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      AppSnackbar.showSuccess(
        context,
        'Boilerplate Arsitektur Berhasil Berjalan!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Petugas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Selamat Datang', style: AppTypography.headlineLarge),
            const SizedBox(height: 8),
            const Text(
              'Silakan masuk menggunakan NIP dan Password Anda',
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 32),

            // Input NIP menggunakan AppTextField
            AppTextField(
              label: 'NIP Petugas',
              hint: 'Masukkan NIP Anda',
              controller: _nipController,
              // keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 20),

            // Input Password dengan toggle mata otomatis
            AppTextField(
              label: 'Kata Sandi',
              hint: 'Masukkan kata sandi',
              controller: _passwordController,
              isPassword: true,
              prefixIcon: const Icon(Icons.lock_outline),
            ),
            const SizedBox(height: 32),

            // Tombol Login menggunakan AppButton
            AppButton(
              text: 'Masuk ke Aplikasi',
              isLoading: _isLoading,
              onPressed: _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
