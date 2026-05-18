import 'package:flutter/material.dart';

import '../app.dart';
import '../models/user_profile.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar_view.dart';
import 'chat_page.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController _nameController = TextEditingController();
  final Set<String> _selectedIds = <String>{};

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contacts = appState.contacts;
    return Scaffold(
      appBar: AppBar(title: const Text('创建群聊')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '群聊名称（可选）',
                hintText: '不填时自动根据成员生成',
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              itemCount: contacts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final user = contacts[index];
                final selected = _selectedIds.contains(user.id);
                return Card(
                  child: CheckboxListTile(
                    value: selected,
                    onChanged: (_) {
                      setState(() {
                        if (selected) {
                          _selectedIds.remove(user.id);
                        } else {
                          _selectedIds.add(user.id);
                        }
                      });
                    },
                    secondary: AvatarView(label: user.nickname, colorValue: user.avatarColorValue),
                    title: Text(user.nickname),
                    subtitle: Text(user.bio),
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _selectedIds.isEmpty
                      ? null
                      : () {
                          final selectedUsers = contacts.where((user) => _selectedIds.contains(user.id)).toList();
                          final conversationId = appState.createGroup(
                            name: _nameController.text,
                            members: selectedUsers,
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => ChatPage(conversationId: conversationId)),
                          );
                        },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.brandGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('创建群聊（${_selectedIds.length}）'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
