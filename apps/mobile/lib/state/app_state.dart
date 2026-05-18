import 'dart:math';

import 'package:flutter/foundation.dart';

import '../data/mock_repository.dart';
import '../models/chat_message.dart';
import '../models/conversation.dart';
import '../models/friend_request.dart';
import '../models/red_packet.dart';
import '../models/user_profile.dart';
import '../models/wallet_account.dart';
import '../models/wallet_transaction.dart';

class AppState extends ChangeNotifier {
  AppState() : _repo = MockRepository();

  final MockRepository _repo;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  UserProfile get me => _repo.me;
  WalletAccount get walletAccount => _repo.walletAccount;

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

  List<WalletTransaction> get walletTransactions {
    final items = [..._repo.walletTransactions];
    items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items;
  }

  List<RedPacketRecord> get redPackets {
    final items = [..._repo.redPackets];
    items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
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

  void mockRecharge(double amount) {
    if (amount <= 0) return;
    final now = DateTime.now();
    final nextBalance = _repo.walletAccount.balance + amount;
    _repo.walletAccount = _repo.walletAccount.copyWith(balance: nextBalance);
    _repo.walletTransactions.insert(
      0,
      WalletTransaction(
        id: 'wt_${Random().nextInt(99999)}',
        type: WalletTransactionType.recharge,
        direction: WalletTransactionDirection.income,
        title: '钱包充值',
        amount: amount,
        balanceAfter: nextBalance,
        createdAt: now,
        description: '发现页快捷充值（Mock）',
      ),
    );
    notifyListeners();
  }

  bool sendRedPacket({
    required RedPacketType type,
    required String targetName,
    required double amount,
    required String greeting,
  }) {
    if (amount <= 0 || targetName.trim().isEmpty) return false;
    if (_repo.walletAccount.balance < amount) return false;

    final now = DateTime.now();
    final nextBalance = _repo.walletAccount.balance - amount;
    final nextFrozen = _repo.walletAccount.frozenBalance + amount;

    _repo.walletAccount = _repo.walletAccount.copyWith(
      balance: nextBalance,
      frozenBalance: nextFrozen,
    );

    _repo.redPackets.insert(
      0,
      RedPacketRecord(
        id: 'rp_${Random().nextInt(99999)}',
        type: type,
        targetName: targetName.trim(),
        amount: amount,
        greeting: greeting.trim().isEmpty ? '恭喜发财，大吉大利' : greeting.trim(),
        status: RedPacketStatus.pending,
        createdAt: now,
        claimedCount: 0,
        totalCount: type == RedPacketType.single ? 1 : 5,
      ),
    );

    _repo.walletTransactions.insert(
      0,
      WalletTransaction(
        id: 'wt_${Random().nextInt(99999)}',
        type: WalletTransactionType.freeze,
        direction: WalletTransactionDirection.freeze,
        title: '红包冻结',
        amount: amount,
        balanceAfter: nextBalance,
        createdAt: now,
        description: targetName.trim(),
      ),
    );

    notifyListeners();
    return true;
  }
}
