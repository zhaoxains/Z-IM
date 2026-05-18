enum MessageKind { text, image, file, system }

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.kind,
    required this.content,
    required this.createdAt,
    this.isRead = false,
    this.isMine = false,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final MessageKind kind;
  final String content;
  final DateTime createdAt;
  final bool isRead;
  final bool isMine;

  ChatMessage copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    MessageKind? kind,
    String? content,
    DateTime? createdAt,
    bool? isRead,
    bool? isMine,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      kind: kind ?? this.kind,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      isMine: isMine ?? this.isMine,
    );
  }
}
