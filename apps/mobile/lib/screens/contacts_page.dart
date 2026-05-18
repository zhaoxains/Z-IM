import 'package:flutter/material.dart';

import '../app.dart';
import '../models/user_profile.dart';
import '../widgets/avatar_view.dart';
import 'chat_page.dart';
import 'new_friends_page.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        final contacts = appState.contacts;
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          children: [
            _ActionTile(
              icon: Icons.person_add_alt_1,
              title: '新的朋友',
              subtitle: '查看好友申请与处理记录',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NewFriendsPage()),
                );
              },
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text('联系人', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            ...contacts.map((user) => _ContactTile(user: user)),
          ],
        );
      },
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE8F8F0),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          final conversationId = appState.ensureSingleConversation(user);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ChatPage(conversationId: conversationId)),
          );
        },
        leading: AvatarView(label: user.nickname, colorValue: user.avatarColorValue),
        title: Text(user.nickname),
        subtitle: Text(user.bio),
        trailing: user.isOnline
            ? const Text('在线', style: TextStyle(color: Color(0xFF07C160), fontSize: 12))
            : const Text('离线', style: TextStyle(color: Color(0xFF86909C), fontSize: 12)),
      ),
    );
  }
}
