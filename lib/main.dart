import 'package:crypto_app/core/constants/app_constant.dart';
import 'package:crypto_app/core/routes/app_routes.dart';
import 'package:crypto_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstant.designSize,
      builder: (_, __) => GetMaterialApp(
        title: AppConstant.appName,
        theme: AppTheme.themeData,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.dashboard,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
