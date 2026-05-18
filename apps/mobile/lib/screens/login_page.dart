import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mobileController = TextEditingController(text: '13800138000');
  final TextEditingController _codeController = TextEditingController(text: '123456');

  @override
  void dispose() {
    _mobileController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.pageBackground,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: AppTheme.brandGreen,
                  borderRadius: BorderRadius.circular(22),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'IM',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '欢迎使用 Z-IM',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 12),
              const Text(
                'Flutter 版个人社交 IM 原型，当前已切换为更接近 iOS 的界面风格，并使用 Mock 数据演示聊天流程。',
                style: TextStyle(fontSize: 15, color: AppTheme.textSecondary, height: 1.6),
              ),
              const SizedBox(height: 28),
              _InputCard(
                child: CupertinoTextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  placeholder: '手机号',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Icon(CupertinoIcons.phone, color: AppTheme.textSecondary, size: 20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: null,
                ),
              ),
              const SizedBox(height: 14),
              _InputCard(
                child: CupertinoTextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  placeholder: '验证码（演示默认 123456）',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Icon(CupertinoIcons.lock, color: AppTheme.textSecondary, size: 20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: null,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                '后续将逐个补齐：发现页、钱包、红包、音视频、支付和授权模块。',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 220),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: () => appState.login(_mobileController.text),
                  borderRadius: BorderRadius.circular(14),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text('进入原型'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
