import 'package:crypto_app/feature/dashboard/bindings/crypto_binding.dart';
import 'package:crypto_app/feature/dashboard/view/dashboard_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String dashboard = '/';

  static List<GetPage> get routes => [
    GetPage(
      name: dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
  ];
}
