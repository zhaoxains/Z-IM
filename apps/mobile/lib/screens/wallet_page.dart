import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../theme/app_theme.dart';
import '../widgets/inset_section.dart';
import 'wallet_transactions_page.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('钱包')),
      child: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, _) {
            final account = appState.walletAccount;
            return ListView(
              padding: const EdgeInsets.fromLTRB(0, 14, 0, 24),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppTheme.brandGreen,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '可用余额',
                            style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '¥ ${account.balance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: _StatCard(
                                  label: '冻结中',
                                  value: '¥ ${account.frozenBalance.toStringAsFixed(2)}',
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _StatCard(
                                  label: '本次版本',
                                  value: 'Mock 钱包',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoButton.filled(
                          borderRadius: BorderRadius.circular(14),
                          onPressed: () => _showRechargeSheet(context),
                          child: const Text('充值'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CupertinoButton(
                          color: const Color(0xFFE8F8F0),
                          borderRadius: BorderRadius.circular(14),
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(builder: (_) => const WalletTransactionsPage()),
                            );
                          },
                          child: const Text(
                            '余额明细',
                            style: TextStyle(color: AppTheme.brandGreen),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                InsetSection(
                  header: '能力',
                  children: [
                    InsetTile(
                      leading: const _WalletIcon(icon: CupertinoIcons.money_dollar_circle_fill, color: Color(0xFFF6BD16)),
                      title: '余额明细',
                      subtitle: '查看充值、红包、冻结与退回流水',
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(builder: (_) => const WalletTransactionsPage()),
                        );
                      },
                    ),
                    const InsetTile(
                      leading: _WalletIcon(icon: CupertinoIcons.creditcard_fill, color: Color(0xFF5B8FF9)),
                      title: '支付方式',
                      subtitle: '支付宝、微信支付接入后在此展示',
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showRechargeSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('快捷充值'),
        message: const Text('当前为原型演示，充值后只更新本地 Mock 数据。'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              appState.mockRecharge(30);
            },
            child: const Text('充值 ¥30'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              appState.mockRecharge(100);
            },
            child: const Text('充值 ¥100'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              appState.mockRecharge(500);
            },
            child: const Text('充值 ¥500'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x1FFFFFFF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Color(0xCCFFFFFF), fontSize: 12)),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletIcon extends StatelessWidget {
  const _WalletIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
