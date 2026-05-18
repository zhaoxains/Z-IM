import 'package:flutter/material.dart';

import '../app.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar_view.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final me = appState.me;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                AvatarView(label: me.nickname, colorValue: me.avatarColorValue, size: 64),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(me.nickname, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(me.bio, style: const TextStyle(color: AppTheme.textSecondary)),
                      const SizedBox(height: 6),
                      Text('手机号：${me.mobile}', style: const TextStyle(color: AppTheme.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const _SettingTile(icon: Icons.shield_outlined, title: '账号与安全', subtitle: '设备管理、登录保护、隐私设置'),
        const _SettingTile(icon: Icons.notifications_none_rounded, title: '消息通知', subtitle: '声音、震动、免打扰'),
        const _SettingTile(icon: Icons.palette_outlined, title: '界面偏好', subtitle: '主题、字体大小、聊天背景'),
        const _SettingTile(icon: Icons.help_outline_rounded, title: '帮助与反馈', subtitle: '功能说明、问题反馈、版本信息'),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
