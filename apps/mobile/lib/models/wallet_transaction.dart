enum WalletTransactionType {
  recharge,
  redPacketSend,
  redPacketReceive,
  refund,
  freeze,
  unfreeze,
}

enum WalletTransactionDirection { income, expense, freeze, unfreeze }

class WalletTransaction {
  const WalletTransaction({
    required this.id,
    required this.type,
    required this.direction,
    required this.title,
    required this.amount,
    required this.balanceAfter,
    required this.createdAt,
    this.description,
  });

  final String id;
  final WalletTransactionType type;
  final WalletTransactionDirection direction;
  final String title;
  final double amount;
  final double balanceAfter;
  final DateTime createdAt;
  final String? description;

  WalletTransaction copyWith({
    String? id,
    WalletTransactionType? type,
    WalletTransactionDirection? direction,
    String? title,
    double? amount,
    double? balanceAfter,
    DateTime? createdAt,
    String? description,
  }) {
    return WalletTransaction(
      id: id ?? this.id,
      type: type ?? this.type,
      direction: direction ?? this.direction,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
    );
  }
}
