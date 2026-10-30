import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum ButtonVariant { primary, secondary, outlined, danger }

/// Tombol standar aplikasi yang mendukung berbagai varian warna dan state loading.
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonVariant variant;
  final IconData? icon;
  final double? width;
  final double height;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    // Tombol non-aktif jika sedang loading atau onPressed bernilai null
    final isEnabled = onPressed != null && !isLoading;

    Color backgroundColor;
    Color textColor;
    BorderSide? borderSide;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = AppColors.primary;
        textColor = Colors.white;
        break;
      case ButtonVariant.secondary:
        backgroundColor = AppColors.secondary;
        textColor = Colors.black;
        break;
      case ButtonVariant.outlined:
        backgroundColor = Colors.transparent;
        textColor = AppColors.primary;
        borderSide = const BorderSide(color: AppColors.primary, width: 1.5);
        break;
      case ButtonVariant.danger:
        backgroundColor = AppColors.danger;
        textColor = Colors.white;
        break;
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: borderSide ?? BorderSide.none,
          ),
          disabledBackgroundColor: AppColors.border,
          disabledForegroundColor: AppColors.textDisabled,
        ),
        onPressed: isEnabled ? onPressed : null,
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: textColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: textColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: AppTypography.labelButton.copyWith(color: textColor),
                  ),
                ],
              ),
      ),
    );
  }
}
