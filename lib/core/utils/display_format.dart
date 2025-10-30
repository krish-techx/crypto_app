import 'package:intl/intl.dart';

class DisplayFormat {
  static String lastUpdateTime(timestamp) {
    final lastUpdate = timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toLocal()
        : DateTime.now().toLocal();

    final formatted = DateFormat('hh:mm:ss a').format(lastUpdate);
    return formatted;
  }

  static String formatUsd(currency) {
    final usdFormat = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    );

    return usdFormat.format(currency);
  }
}
