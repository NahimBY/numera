import 'package:flutter/material.dart';

import '../config/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color bgColor;
  final double? elevation;
  final bool isOutlined;
  final bool isMainButton;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.bgColor = AppColors.primary,
    this.elevation = 1,
    this.isOutlined = false,
    this.isMainButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return isMainButton
        ? ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: elevation,
            side:
                isOutlined
                    ? BorderSide(color: AppColors.fillPaleGrayWithTransparency)
                    : BorderSide.none,
          ),
          onPressed: isLoading ? null : onPressed,
          child:
              isLoading
                  ? const CircularProgressIndicator()
                  : Text(text, style: AppFonts.buttonText),
        )
        : OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: elevation,
            side: BorderSide(color: AppColors.primary, width: 2),
          ),
          onPressed: isLoading ? null : onPressed,
          child:
              isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                    text,
                    style: AppFonts.buttonText.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
        );
  }
}
