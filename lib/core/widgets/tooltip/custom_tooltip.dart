import 'package:crypto_app/core/constants/app_color.dart';
import 'package:crypto_app/core/constants/app_spacing.dart';
import 'package:crypto_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTooltip extends StatefulWidget {
  final Widget content;

  const CustomTooltip({super.key, required this.content});

  @override
  State<CustomTooltip> createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> {
  OverlayEntry? _entry;

  void _showTooltip() {
    _entry?.remove();

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    double tooltipWidth = context.width * 0.8;
    double left = offset.dx;

    if (left + tooltipWidth > context.width) {
      left = context.width - tooltipWidth - (AppSpacing.small * 2);
    }

    _entry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy + size.height + 8,
        left: left,
        child: Material(
          color: AppColors.transparent,
          child: Container(
            width: tooltipWidth,
            padding: const EdgeInsets.all(AppSpacing.small),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(AppSpacing.radius8.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.3),
                  blurRadius: AppSpacing.radius8.r,
                  offset: Offset(0, (AppSpacing.small / 2).h),
                ),
              ],
            ),
            child: widget.content,
          ),
        ),
      ),
    );

    overlay.insert(_entry!);
    Future.delayed(const Duration(milliseconds: 3200), () {
      _entry?.remove();
      _entry = null;
    });
  }

  @override
  void dispose() {
    _entry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showTooltip,
      child: Icon(Icons.info_outline, color: AppColors.surface, size: 20.w),
    );
  }
}
