import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../models/user_profile.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar_view.dart';
import '../widgets/inset_section.dart';
import 'chat_page.dart';
import 'new_friends_page.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('通讯录')),
      child: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, _) {
            final contacts = appState.contacts;
            return ListView(
              padding: const EdgeInsets.fromLTRB(0, 14, 0, 24),
              children: [
                InsetSection(
                  children: [
                    InsetTile(
                      leading: const _SquareIcon(icon: CupertinoIcons.person_add_solid),
                      title: '新的朋友',
                      subtitle: '查看好友申请与处理记录',
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(builder: (_) => const NewFriendsPage()),
                        );
                      },
                    ),
                  ],
                ),
                InsetSection(
                  header: '联系人',
                  children: contacts.map((user) => _ContactTile(user: user)).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return InsetTile(
      leading: AvatarView(label: user.nickname, colorValue: user.avatarColorValue),
      title: user.nickname,
      subtitle: user.bio,
      trailing: Text(
        user.isOnline ? '在线' : '离线',
        style: TextStyle(
          color: user.isOnline ? AppTheme.brandGreen : AppTheme.textSecondary,
          fontSize: 12,
        ),
      ),
      onTap: () {
        final conversationId = appState.ensureSingleConversation(user);
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => ChatPage(conversationId: conversationId)),
        );
      },
    );
  }
}

class _SquareIcon extends StatelessWidget {
  const _SquareIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F8F0),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: AppTheme.brandGreen, size: 22),
    );
  }
}
