import 'dart:async';

import 'package:crypto_app/core/constants/app_constant.dart';
import 'package:crypto_app/core/network/api_service.dart';
import 'package:crypto_app/core/utils/display_format.dart';
import 'package:crypto_app/core/utils/snackbar_util.dart';
import 'package:crypto_app/feature/dashboard/models/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CryptoController extends GetxController {
  final RxBool _isInitLoading = true.obs;
  final RxBool _isDataRefresh = false.obs;
  final RxBool _coinRefresh = false.obs;

  final Rx<CryptoModal> _selectedCoin = CryptoModal(
    id: 'bitcoin',
    symbol: 'BTC',
    name: 'Bitcoin',
    imageUrl:
        'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
  ).obs;

  final RxDouble _price = 0.0.obs;
  final RxnString _priceErrorMsg = RxnString();
  final RxnString _lastUpdateTime = RxnString();

  Timer? _timer;

  bool get isInitLoading => _isInitLoading.value;
  bool get coinRefresh => _coinRefresh.value;

  Rx<CryptoModal> get selectedCoin => _selectedCoin;

  double get price => _price.value;

  String? get priceErrorMsg => _priceErrorMsg.value;
  String? get lastUpdateTime => _lastUpdateTime.value;

  set selectedCoinValue(CryptoModal value) => _selectedCoin.value = value;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Fetch default coin price on init
      await _fetchPrice();

      // Fetch price periodically
      _startPeriodicTimer();

      // Fetch price on change
      ever<CryptoModal?>(selectedCoin, (coinId) async {
        _coinRefresh.value = true;
        _timer?.cancel();
        _lastUpdateTime.value = null;
        _price.value = 0.0;
        await _fetchPrice();
        _startPeriodicTimer();
        _coinRefresh.value = false;
      });

      _isInitLoading.value = false;
    });
  }

  void _startPeriodicTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: AppConstant.livePriceFetchRateInSec),
      (_) => _fetchPrice(),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> _fetchPrice() async {
    if (_isDataRefresh.value) return;

    final coinId = _selectedCoin.value.id;

    try {
      _isDataRefresh.value = true;
      _priceErrorMsg.value = null;

      await Future.delayed(const Duration(seconds: 5));

      // Price
      final response = await ApiService.instance.getPrice(
        coinId: _selectedCoin.value.id,
      );
      final priceData = response[coinId]?['usd']?.toDouble();
      _price.value = priceData ?? _price.value;

      // Last update
      final timestamp = response[coinId]?['last_updated_at'];
      _lastUpdateTime.value = DisplayFormat.lastUpdateTime(timestamp);
    } catch (e) {
      _priceErrorMsg.value = '$e';
      SnackbarUtil.showError('$e');
    } finally {
      _isDataRefresh.value = false;
    }
  }
}
