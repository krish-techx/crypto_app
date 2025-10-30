class CryptoModal {
  final String? id;
  final String? symbol;
  final String? name;
  final String? imageUrl;

  CryptoModal({this.id, this.symbol, this.name, this.imageUrl});

  factory CryptoModal.fromJson(Map<String, dynamic> json) {
    return CryptoModal(
      id: json['id'] ?? '',
      symbol: (json['symbol'] ?? '').toUpperCase(),
      name: json['name'] ?? '',
      imageUrl: json['image'] ?? '',
    );
  }
}
