import 'package:crypto_app/feature/dashboard/controllers/crypto_controller.dart';
import 'package:crypto_app/feature/dashboard/controllers/trading_chart_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CryptoController>(() => CryptoController());
    Get.lazyPut<TradingChartController>(() => TradingChartController());
  }
}
