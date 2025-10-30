import 'package:crypto_app/core/constants/app_color.dart';
import 'package:crypto_app/core/constants/app_spacing.dart';
import 'package:crypto_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.white.withValues(alpha: 0.6),
      highlightColor: AppColors.white.withValues(alpha: 0.7),
      child: Column(
        children: [
          // Select Coin
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.small.w,
              vertical: AppSpacing.small.h,
            ),
            child: Column(
              children: [
                Container(
                  height: 64.h,
                  width: context.width * 0.6,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppSpacing.radius8.r),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.h16,

          // Live price
          Container(
            height: 42.h,
            width: 160.w,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radius8.r),
            ),
          ),
          AppSpacing.h16,

          // Trading Chart
          Expanded(
            child: Container(
              width: double.infinity,
              color: AppColors.white.withValues(alpha: 0.16),
            ),
          ),
        ],
      ),
    );
  }
}
