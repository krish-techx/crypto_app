import 'package:crypto_app/feature/dashboard/controllers/crypto_controller.dart';
import 'package:crypto_app/feature/dashboard/controllers/trading_chart_controller.dart';
import 'package:crypto_app/feature/dashboard/view/widgets/graph_view_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingViewChart extends StatelessWidget {
  const TradingViewChart({super.key});

  @override
  Widget build(BuildContext context) {
    final chartController = Get.find<TradingChartController>();
    final cryptoController = Get.find<CryptoController>();

    return Obx(() {
      if (chartController.isLoading || cryptoController.coinRefresh) {
        return const GraphViewShimmer();
      }
      return WebViewWidget(controller: chartController.webController);
    });
  }
}
