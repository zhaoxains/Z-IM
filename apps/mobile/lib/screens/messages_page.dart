import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../models/conversation.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar_view.dart';
import 'chat_page.dart';
import 'create_group_page.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('消息'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(builder: (_) => const CreateGroupPage()),
            );
          },
          child: const Icon(CupertinoIcons.add_circled, size: 24),
        ),
      ),
      child: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, _) {
            final conversations = appState.conversations;
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
              itemCount: conversations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return _ConversationCard(conversation: conversation);
              },
            );
          },
        ),
      ),
    );
  }
}

class _ConversationCard extends StatelessWidget {
  const _ConversationCard({required this.conversation});

  final ConversationSummary conversation;

  @override
  Widget build(BuildContext context) {
    final timeLabel = _formatTime(conversation.lastMessageAt);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        appState.markConversationRead(conversation.id);
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => ChatPage(conversationId: conversation.id)),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              AvatarView(label: conversation.title, colorValue: conversation.avatarColorValue, size: 50),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.title,
                            style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          timeLabel,
                          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.lastMessagePreview,
                            style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (conversation.unreadCount > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF3B30),
                              borderRadius: BorderRadius.all(Radius.circular(999)),
                            ),
                            child: Text(
                              '${conversation.unreadCount}',
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (conversation.isPinned) ...[
                      const SizedBox(height: 8),
                      const Text(
                        '已置顶',
                        style: TextStyle(fontSize: 12, color: AppTheme.brandGreen),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    if (difference.inMinutes < 60) return '${difference.inMinutes}分钟前';
    if (difference.inHours < 24) return '${difference.inHours}小时前';
    return '${time.month}/${time.day}';
  }
}
