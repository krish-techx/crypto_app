import 'package:crypto_app/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GraphViewShimmer extends StatelessWidget {
  const GraphViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surface,
      highlightColor: AppColors.surface.withValues(alpha: 0.2),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.black,
      ),
    );
  }
}
