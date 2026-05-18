class WalletAccount {
  const WalletAccount({
    required this.userId,
    required this.balance,
    required this.frozenBalance,
  });

  final String userId;
  final double balance;
  final double frozenBalance;

  WalletAccount copyWith({
    String? userId,
    double? balance,
    double? frozenBalance,
  }) {
    return WalletAccount(
      userId: userId ?? this.userId,
      balance: balance ?? this.balance,
      frozenBalance: frozenBalance ?? this.frozenBalance,
    );
  }
}
