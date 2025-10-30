import 'package:crypto_app/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final double cutSize = AppSpacing.small.w;
    final double radius = AppSpacing.radius8.r;
    final double cutRadius = 2.r;

    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    path.lineTo(size.width, size.height - cutSize - cutRadius);

    path.quadraticBezierTo(
      size.width,
      size.height - cutSize,
      size.width - cutRadius,
      size.height - cutSize + cutRadius,
    );

    path.lineTo(size.width - cutSize + cutRadius, size.height - cutRadius);
    path.quadraticBezierTo(
      size.width - cutSize,
      size.height,
      size.width - cutSize - cutRadius,
      size.height,
    );

    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
