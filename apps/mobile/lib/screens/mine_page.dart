import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar_view.dart';
import '../widgets/inset_section.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final me = appState.me;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('我的')),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 14, 0, 24),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      AvatarView(label: me.nickname, colorValue: me.avatarColorValue, size: 66),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              me.nickname,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(me.bio, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
                            const SizedBox(height: 6),
                            Text('手机号：${me.mobile}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const InsetSection(
              header: '账号',
              children: [
                InsetTile(
                  leading: _MineIcon(icon: CupertinoIcons.shield_fill, color: Color(0xFF5B8FF9)),
                  title: '账号与安全',
                  subtitle: '设备管理、登录保护、隐私设置',
                ),
                InsetTile(
                  leading: _MineIcon(icon: CupertinoIcons.bell_fill, color: Color(0xFFF6BD16)),
                  title: '消息通知',
                  subtitle: '声音、震动、免打扰',
                ),
              ],
            ),
            const InsetSection(
              header: '界面与帮助',
              children: [
                InsetTile(
                  leading: _MineIcon(icon: CupertinoIcons.paintbrush_fill, color: Color(0xFF9270CA)),
                  title: '界面偏好',
                  subtitle: '主题、字体大小、聊天背景',
                ),
                InsetTile(
                  leading: _MineIcon(icon: CupertinoIcons.question_circle_fill, color: AppTheme.brandGreen),
                  title: '帮助与反馈',
                  subtitle: '功能说明、问题反馈、版本信息',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoButton(
                color: AppTheme.danger,
                borderRadius: BorderRadius.circular(14),
                onPressed: appState.logout,
                child: const Text('退出登录'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MineIcon extends StatelessWidget {
  const _MineIcon({required this.icon, required this.color});

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
