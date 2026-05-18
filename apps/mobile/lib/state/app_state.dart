import 'dart:math';

import 'package:flutter/foundation.dart';

import '../data/mock_repository.dart';
import '../models/chat_message.dart';
import '../models/conversation.dart';
import '../models/friend_request.dart';
import '../models/user_profile.dart';

class AppState extends ChangeNotifier {
  AppState() : _repo = MockRepository();

  final MockRepository _repo;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  UserProfile get me => _repo.me;

  List<UserProfile> get contacts => List.unmodifiable(_repo.contacts);

  List<FriendRequest> get friendRequests {
    final items = [..._repo.friendRequests];
    items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items;
  }

  List<ConversationSummary> get conversations {
    final items = [..._repo.conversations];
    items.sort((a, b) {
      if (a.isPinned != b.isPinned) {
        return a.isPinned ? -1 : 1;
      }
      return b.lastMessageAt.compareTo(a.lastMessageAt);
    });
    return items;
  }

  List<ChatMessage> messagesFor(String conversationId) {
    final items = _repo.messagesByConversation[conversationId] ?? <ChatMessage>[];
    final result = [...items];
    result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return result;
  }

  UserProfile userById(String id) => _repo.userById(id);

  void login(String mobile) {
    if (mobile.trim().isEmpty) return;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void markConversationRead(String conversationId) {
    final index = _repo.conversations.indexWhere((item) => item.id == conversationId);
    if (index == -1) return;
    _repo.conversations[index] = _repo.conversations[index].copyWith(unreadCount: 0);
    notifyListeners();
  }

  String ensureSingleConversation(UserProfile user) {
    final existing = _repo.conversations.where((conversation) {
      return conversation.type == ConversationType.single &&
          conversation.participantIds.contains(me.id) &&
          conversation.participantIds.contains(user.id);
    });
    if (existing.isNotEmpty) {
      return existing.first.id;
    }

    final id = 'c_${user.id}_${Random().nextInt(9999)}';
    _repo.conversations.insert(
      0,
      ConversationSummary(
        id: id,
        type: ConversationType.single,
        title: user.nickname,
        avatarColorValue: user.avatarColorValue,
        participantIds: [me.id, user.id],
        lastMessagePreview: '你们已经成为好友，开始聊天吧。',
        lastMessageAt: DateTime.now(),
      ),
    );
    _repo.messagesByConversation[id] = [
      ChatMessage(
        id: 'm_${Random().nextInt(99999)}',
        conversationId: id,
        senderId: me.id,
        kind: MessageKind.system,
        content: '你们已经成为好友，开始聊天吧。',
        createdAt: DateTime.now(),
        isMine: true,
        isRead: true,
      ),
    ];
    notifyListeners();
    return id;
  }

  void sendTextMessage(String conversationId, String text) {
    final value = text.trim();
    if (value.isEmpty) return;

    final message = ChatMessage(
      id: 'm_${Random().nextInt(99999)}',
      conversationId: conversationId,
      senderId: me.id,
      kind: MessageKind.text,
      content: value,
      createdAt: DateTime.now(),
      isMine: true,
      isRead: true,
    );

    final messages = _repo.messagesByConversation.putIfAbsent(conversationId, () => []);
    messages.add(message);

    final index = _repo.conversations.indexWhere((item) => item.id == conversationId);
    if (index != -1) {
      _repo.conversations[index] = _repo.conversations[index].copyWith(
        lastMessagePreview: value,
        lastMessageAt: message.createdAt,
      );
    }
    notifyListeners();
  }

  String createGroup({required String name, required List<UserProfile> members}) {
    final trimmedName = name.trim().isEmpty
        ? members.map((item) => item.nickname).take(3).join('、')
        : name.trim();
    final id = 'g_${Random().nextInt(99999)}';
    final participantIds = [me.id, ...members.map((item) => item.id)];
    final now = DateTime.now();

    _repo.conversations.insert(
      0,
      ConversationSummary(
        id: id,
        type: ConversationType.group,
        title: trimmedName,
        avatarColorValue: 0xFF86909C,
        participantIds: participantIds,
        lastMessagePreview: '群聊已创建',
        lastMessageAt: now,
      ),
    );

    _repo.messagesByConversation[id] = [
      ChatMessage(
        id: 'm_${Random().nextInt(99999)}',
        conversationId: id,
        senderId: me.id,
        kind: MessageKind.system,
        content: '你创建了群聊“$trimmedName”',
        createdAt: now,
        isMine: true,
        isRead: true,
      ),
    ];

    notifyListeners();
    return id;
  }

  void acceptFriendRequest(String requestId) {
    final index = _repo.friendRequests.indexWhere((item) => item.id == requestId);
    if (index == -1) return;

    final request = _repo.friendRequests[index];
    _repo.friendRequests[index] = request.copyWith(status: FriendRequestStatus.accepted);

    final requester = _repo.userById(request.fromUserId);
    final exists = _repo.contacts.any((item) => item.id == requester.id);
    if (!exists) {
      _repo.contacts.insert(0, requester);
    }
    notifyListeners();
  }
}
