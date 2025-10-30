import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing {
  static const double xSmall = 4.0;
  static const double small = 8.0;

  static const double radius8 = 8.0;
  static const double radius20 = 20.0;

  static SizedBox h4 = SizedBox(height: xSmall.h);
  static SizedBox h8 = SizedBox(height: small.h);
  static SizedBox h16 = SizedBox(height: (small * 2).h);

  static SizedBox w4 = SizedBox(width: xSmall.w);
  static SizedBox w8 = SizedBox(width: small.w);
  static SizedBox w16 = SizedBox(width: small.w * 2);
}
