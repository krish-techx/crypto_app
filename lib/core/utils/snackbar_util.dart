import 'package:crypto_app/core/constants/app_color.dart';
import 'package:crypto_app/core/constants/app_spacing.dart';
import 'package:crypto_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  static void showError(String message, {String title = 'Error'}) {
    Get.closeAllSnackbars();

    Get.snackbar(
      title,
      message,
      titleText: NText(
        text: title,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      messageText: NText(
        text: message,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.overlay,
      borderRadius: AppSpacing.radius20.r,
      icon: Icon(Icons.error_outline, color: AppColors.white, size: 32.w),
      duration: const Duration(seconds: 3),
      shouldIconPulse: true,
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.all((AppSpacing.small * 2).w),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.small.w,
        vertical: AppSpacing.small.h,
      ),
    );
  }
}
