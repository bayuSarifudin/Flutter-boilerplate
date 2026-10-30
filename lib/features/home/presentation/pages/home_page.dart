import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: const Center(
        child: Text(
          'Halaman Dashboard (Placeholder)',
          style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
