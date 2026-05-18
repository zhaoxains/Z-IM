enum ConversationType { single, group }

class ConversationSummary {
  const ConversationSummary({
    required this.id,
    required this.type,
    required this.title,
    required this.avatarColorValue,
    required this.participantIds,
    required this.lastMessagePreview,
    required this.lastMessageAt,
    this.unreadCount = 0,
    this.isPinned = false,
  });

  final String id;
  final ConversationType type;
  final String title;
  final int avatarColorValue;
  final List<String> participantIds;
  final String lastMessagePreview;
  final DateTime lastMessageAt;
  final int unreadCount;
  final bool isPinned;

  ConversationSummary copyWith({
    String? id,
    ConversationType? type,
    String? title,
    int? avatarColorValue,
    List<String>? participantIds,
    String? lastMessagePreview,
    DateTime? lastMessageAt,
    int? unreadCount,
    bool? isPinned,
  }) {
    return ConversationSummary(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      avatarColorValue: avatarColorValue ?? this.avatarColorValue,
      participantIds: participantIds ?? this.participantIds,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
