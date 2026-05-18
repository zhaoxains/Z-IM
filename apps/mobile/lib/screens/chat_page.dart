import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../models/chat_message.dart';
import '../models/conversation.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar_view.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final conversation = appState.conversations.firstWhere((item) => item.id == widget.conversationId);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(conversation.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(CupertinoIcons.phone, size: 20),
            SizedBox(width: 12),
            Icon(CupertinoIcons.videocam, size: 22),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: appState,
                builder: (context, _) {
                  final messages = appState.messagesFor(widget.conversationId);
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                    itemCount: messages.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return _MessageBubble(conversation: conversation, message: message);
                    },
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border(top: BorderSide(color: AppTheme.divider)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: _controller,
                          placeholder: '输入消息',
                          minLines: 1,
                          maxLines: 4,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.pageBackground,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        color: AppTheme.brandGreen,
                        borderRadius: BorderRadius.circular(14),
                        onPressed: () {
                          appState.sendTextMessage(widget.conversationId, _controller.text);
                          _controller.clear();
                        },
                        child: const Text('发送'),
                      ),
                    ],
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

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.conversation, required this.message});

  final ConversationSummary conversation;
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    if (message.kind == MessageKind.system) {
      return Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              message.content,
              style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
            ),
          ),
        ),
      );
    }

    final sender = appState.userById(message.senderId);
    final isMine = message.isMine;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMine) ...[
          AvatarView(label: sender.nickname, colorValue: sender.avatarColorValue, size: 38),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (conversation.type == ConversationType.group && !isMine)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    sender.nickname,
                    style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: isMine ? AppTheme.brandGreen : CupertinoColors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 15,
                      color: isMine ? CupertinoColors.white : AppTheme.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isMine) ...[
          const SizedBox(width: 8),
          AvatarView(label: sender.nickname, colorValue: sender.avatarColorValue, size: 38),
        ],
      ],
    );
  }
}
