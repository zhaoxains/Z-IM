import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar_view.dart';
import '../widgets/inset_section.dart';
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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('创建群聊')),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CupertinoTextField(
                  controller: _nameController,
                  placeholder: '群聊名称（可选，不填将自动生成）',
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  decoration: null,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 12),
                children: [
                  InsetSection(
                    header: '选择好友',
                    children: contacts.map((user) {
                      final selected = _selectedIds.contains(user.id);
                      return InsetTile(
                        leading: AvatarView(label: user.nickname, colorValue: user.avatarColorValue),
                        title: user.nickname,
                        subtitle: user.bio,
                        trailing: Icon(
                          selected ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.circle,
                          color: selected ? AppTheme.brandGreen : AppTheme.textSecondary,
                          size: 22,
                        ),
                        onTap: () {
                          setState(() {
                            if (selected) {
                              _selectedIds.remove(user.id);
                            } else {
                              _selectedIds.add(user.id);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(14),
                    onPressed: _selectedIds.isEmpty
                        ? null
                        : () {
                            final selectedUsers = contacts.where((user) => _selectedIds.contains(user.id)).toList();
                            final conversationId = appState.createGroup(
                              name: _nameController.text,
                              members: selectedUsers,
                            );
                            Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(builder: (_) => ChatPage(conversationId: conversationId)),
                            );
                          },
                    child: Text('创建群聊（${_selectedIds.length}）'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
