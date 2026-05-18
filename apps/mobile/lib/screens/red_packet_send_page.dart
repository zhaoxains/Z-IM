import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../models/red_packet.dart';
import '../theme/app_theme.dart';

class RedPacketSendPage extends StatefulWidget {
  const RedPacketSendPage({super.key});

  @override
  State<RedPacketSendPage> createState() => _RedPacketSendPageState();
}

class _RedPacketSendPageState extends State<RedPacketSendPage> {
  final TextEditingController _targetController = TextEditingController(text: '产品设计群');
  final TextEditingController _amountController = TextEditingController(text: '88');
  final TextEditingController _greetingController = TextEditingController(text: '恭喜发财，大吉大利');
  RedPacketType _type = RedPacketType.groupRandom;

  @override
  void dispose() {
    _targetController.dispose();
    _amountController.dispose();
    _greetingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balance = appState.walletAccount.balance;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('发红包')),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFFE8684A),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('可用余额', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
                    const SizedBox(height: 6),
                    Text(
                      '¥ ${balance.toStringAsFixed(2)}',
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
            const SizedBox(height: 18),
            CupertinoSlidingSegmentedControl<RedPacketType>(
              groupValue: _type,
              children: const {
                RedPacketType.single: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('单聊'),
                ),
                RedPacketType.groupFixed: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('群普通'),
                ),
                RedPacketType.groupRandom: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('拼手气'),
                ),
              },
              onValueChanged: (value) {
                if (value == null) return;
                setState(() => _type = value);
              },
            ),
            const SizedBox(height: 16),
            _InputCard(
              child: CupertinoTextField(
                controller: _targetController,
                placeholder: '发送对象 / 群名称',
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: null,
              ),
            ),
            const SizedBox(height: 12),
            _InputCard(
              child: CupertinoTextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                placeholder: '红包金额',
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: null,
              ),
            ),
            const SizedBox(height: 12),
            _InputCard(
              child: CupertinoTextField(
                controller: _greetingController,
                placeholder: '祝福语',
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: null,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '说明：当前为原型演示，发送红包会扣减余额并写入本地 Mock 记录。',
              style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 24),
            CupertinoButton.filled(
              borderRadius: BorderRadius.circular(14),
              onPressed: () => _submit(context),
              child: const Text('塞钱进红包'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    final success = appState.sendRedPacket(
      type: _type,
      targetName: _targetController.text,
      amount: amount,
      greeting: _greetingController.text,
    );

    final dialog = CupertinoAlertDialog(
      title: Text(success ? '发送成功' : '发送失败'),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(success ? '红包已加入 Mock 记录，并冻结相应余额。' : '请检查对象名称、金额，或确认余额是否充足。'),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('知道了'),
        ),
      ],
    );

    await showCupertinoDialog<void>(context: context, builder: (_) => dialog);
    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }
}

class _InputCard extends StatelessWidget {
  const _InputCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
