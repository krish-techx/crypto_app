import 'dart:convert';

import 'package:crypto_app/core/constants/assets.dart';
import 'package:crypto_app/feature/dashboard/controllers/crypto_controller.dart';
import 'package:crypto_app/feature/dashboard/models/crypto_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingChartController extends GetxController {
  final RxBool _isLoading = true.obs;

  late final WebViewController webController;

  final _cryptoController = Get.find<CryptoController>();

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();

    _initWebView();

    // Refresh graph on coin change
    ever(
      _cryptoController.selectedCoin,
      (CryptoModal coinId) => refreshChart(),
    );
  }

  Future<void> _initWebView() async {
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            _isLoading.value = false;

            refreshChart();
          },
        ),
      );

    final html = await rootBundle.loadString(Assets.htmlTradingview);
    webController.loadHtmlString(html);
  }

  void refreshChart() {
    final coin = _cryptoController.selectedCoin.value;

    final interval = '1H';
    final theme = 'dark';
    final style = '1';
    final symbol = getTradingSymbol(coin.symbol);

    final params = {
      'type': 'loadChart',
      'params': {
        'symbol': symbol,
        'interval': interval,
        'theme': theme,
        'style': style,
      },
    };

    final js = jsonEncode(params);
    webController.runJavaScript('window.postMessage($js)');
  }

  String? getTradingSymbol(
    String? symbol, {
    String exchange = 'BINANCE',
    String quote = 'USD',
  }) {
    if (symbol == null || symbol.isEmpty) return null;

    if (symbol == 'USDT') {
      return '$symbol$quote';
    }

    return '$exchange:$symbol$quote';
  }
}
