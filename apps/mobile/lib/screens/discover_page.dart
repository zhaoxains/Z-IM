import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../theme/app_theme.dart';
import '../widgets/inset_section.dart';
import 'red_packet_records_page.dart';
import 'red_packet_send_page.dart';
import 'wallet_page.dart';
import 'wallet_transactions_page.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('发现')),
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
                            '钱包与增值能力',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '当前原型余额',
                            style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '¥ ${account.balance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InsetSection(
                  header: '钱包',
                  children: [
                    InsetTile(
                      leading: const _FeatureIcon(icon: CupertinoIcons.creditcard_fill, color: Color(0xFF5B8FF9)),
                      title: '钱包',
                      subtitle: '余额、充值、支付方式',
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(builder: (_) => const WalletPage()),
                        );
                      },
                    ),
                    InsetTile(
                      leading: const _FeatureIcon(icon: CupertinoIcons.money_dollar_circle_fill, color: Color(0xFFF6BD16)),
                      title: '余额明细',
                      subtitle: '收入、支出、冻结与退回记录',
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(builder: (_) => const WalletTransactionsPage()),
                        );
                      },
                    ),
                  ],
                ),
                InsetSection(
                  header: '红包',
                  children: [
                    InsetTile(
                      leading: const _FeatureIcon(icon: CupertinoIcons.gift_fill, color: Color(0xFFE8684A)),
                      title: '发红包',
                      subtitle: '单聊红包、群红包、拼手气红包',
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(builder: (_) => const RedPacketSendPage()),
                        );
                      },
                    ),
                    InsetTile(
                      leading: const _FeatureIcon(icon: CupertinoIcons.doc_text_fill, color: Color(0xFF9270CA)),
                      title: '红包记录',
                      subtitle: '查看领取记录、退回状态与订单流水',
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(builder: (_) => const RedPacketRecordsPage()),
                        );
                      },
                    ),
                  ],
                ),
                const InsetSection(
                  header: '音视频与支付',
                  children: [
                    InsetTile(
                      leading: _FeatureIcon(icon: CupertinoIcons.video_camera_solid, color: AppTheme.brandGreen),
                      title: '音视频中心',
                      subtitle: '语音通话、视频通话、通话记录（下一步开发）',
                    ),
                    InsetTile(
                      leading: _FeatureIcon(icon: CupertinoIcons.device_phone_portrait, color: Color(0xFF14B8A6)),
                      title: '支付方式',
                      subtitle: '支付宝、微信支付与充值配置预留',
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
}

class _FeatureIcon extends StatelessWidget {
  const _FeatureIcon({required this.icon, required this.color});

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
