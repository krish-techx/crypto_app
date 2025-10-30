import 'package:crypto_app/feature/dashboard/models/crypto_model.dart';

class NPlaceholders {
  static final List<CryptoModal> cryptoMaster = [
    CryptoModal(
      id: 'bitcoin',
      symbol: 'BTC',
      name: 'Bitcoin',
      imageUrl:
          'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
    ),
    CryptoModal(
      id: 'ethereum',
      symbol: 'ETH',
      name: 'Ethereum',
      imageUrl:
          'https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880',
    ),
    CryptoModal(
      id: 'tether',
      symbol: 'USDT',
      name: 'Tether',
      imageUrl:
          'https://assets.coingecko.com/coins/images/325/large/Tether.png?1668148663',
    ),
  ];
}
