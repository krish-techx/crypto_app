import 'package:crypto_app/core/constants/app_color.dart';
import 'package:crypto_app/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CoinShimmer extends StatelessWidget {
  const CoinShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surface.withValues(alpha: 0.6),
      highlightColor: AppColors.white.withValues(alpha: 0.4),
      child: Container(
        height: 42.h,
        width: 160.w,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(AppSpacing.radius8.r),
        ),
      ),
    );
  }
}
