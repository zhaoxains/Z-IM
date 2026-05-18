import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../models/wallet_transaction.dart';
import '../theme/app_theme.dart';
import '../widgets/inset_section.dart';

class WalletTransactionsPage extends StatelessWidget {
  const WalletTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('余额明细')),
      child: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, _) {
            final items = appState.walletTransactions;
            return ListView(
              padding: const EdgeInsets.only(top: 14, bottom: 24),
              children: [
                InsetSection(
                  children: items.map((item) => _TransactionTile(item: item)).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.item});

  final WalletTransaction item;

  @override
  Widget build(BuildContext context) {
    final prefix = item.direction == WalletTransactionDirection.income || item.direction == WalletTransactionDirection.unfreeze
        ? '+'
        : '-';
    final amountColor = item.direction == WalletTransactionDirection.income || item.direction == WalletTransactionDirection.unfreeze
        ? AppTheme.brandGreen
        : AppTheme.textPrimary;

    return InsetTile(
      leading: _TransactionIcon(direction: item.direction),
      title: item.title,
      subtitle: '${item.description ?? '钱包流水'}\n余额：¥ ${item.balanceAfter.toStringAsFixed(2)}',
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$prefix¥ ${item.amount.toStringAsFixed(2)}',
            style: TextStyle(color: amountColor, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(_timeLabel(item.createdAt), style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  String _timeLabel(DateTime time) {
    return '${time.month}/${time.day} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class _TransactionIcon extends StatelessWidget {
  const _TransactionIcon({required this.direction});

  final WalletTransactionDirection direction;

  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    late final Color color;
    switch (direction) {
      case WalletTransactionDirection.income:
        icon = CupertinoIcons.arrow_down_circle_fill;
        color = AppTheme.brandGreen;
        break;
      case WalletTransactionDirection.expense:
        icon = CupertinoIcons.arrow_up_circle_fill;
        color = const Color(0xFFE8684A);
        break;
      case WalletTransactionDirection.freeze:
        icon = CupertinoIcons.lock_circle_fill;
        color = const Color(0xFFF6BD16);
        break;
      case WalletTransactionDirection.unfreeze:
        icon = CupertinoIcons.refresh_circled_solid;
        color = const Color(0xFF5B8FF9);
        break;
    }

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: color, size: 22),
    );
  }
}
