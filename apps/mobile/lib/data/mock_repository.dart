import '../models/chat_message.dart';
import '../models/conversation.dart';
import '../models/friend_request.dart';
import '../models/red_packet.dart';
import '../models/user_profile.dart';
import '../models/wallet_account.dart';
import '../models/wallet_transaction.dart';

class MockRepository {
  MockRepository();

  final UserProfile me = const UserProfile(
    id: 'u_me',
    nickname: '子航',
    mobile: '13800138000',
    bio: '专注把复杂的事情做简单。',
    avatarColorValue: 0xFF07C160,
    isOnline: true,
  );

  final List<UserProfile> contacts = [
    const UserProfile(
      id: 'u_anna',
      nickname: '安安',
      mobile: '13800000001',
      bio: '今天也要开心沟通。',
      avatarColorValue: 0xFF5B8FF9,
      isOnline: true,
    ),
    const UserProfile(
      id: 'u_brian',
      nickname: '北辰',
      mobile: '13800000002',
      bio: '设计、产品、咖啡。',
      avatarColorValue: 0xFFF6BD16,
      isOnline: false,
    ),
    const UserProfile(
      id: 'u_cici',
      nickname: '茜茜',
      mobile: '13800000003',
      bio: '前端开发者。',
      avatarColorValue: 0xFFE8684A,
      isOnline: true,
    ),
    const UserProfile(
      id: 'u_dylan',
      nickname: '大林',
      mobile: '13800000004',
      bio: '周末去爬山。',
      avatarColorValue: 0xFF9270CA,
      isOnline: false,
    ),
  ];

  final List<FriendRequest> friendRequests = [
    FriendRequest(
      id: 'fr_1',
      fromUserId: 'u_dylan',
      message: '你好，我是大林，想加你聊下合作。',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    FriendRequest(
      id: 'fr_2',
      fromUserId: 'u_cici',
      message: '看到你也在做 IM，交个朋友。',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      status: FriendRequestStatus.accepted,
    ),
  ];

  final List<ConversationSummary> conversations = [
    ConversationSummary(
      id: 'c_anna',
      type: ConversationType.single,
      title: '安安',
      avatarColorValue: 0xFF5B8FF9,
      participantIds: const ['u_me', 'u_anna'],
      lastMessagePreview: '晚上把原型再过一遍。',
      lastMessageAt: DateTime.now().subtract(const Duration(minutes: 8)),
      unreadCount: 2,
      isPinned: true,
    ),
    ConversationSummary(
      id: 'c_group_design',
      type: ConversationType.group,
      title: '产品设计群',
      avatarColorValue: 0xFFF6BD16,
      participantIds: const ['u_me', 'u_anna', 'u_brian', 'u_cici'],
      lastMessagePreview: '北辰：我把新版本流程图更新了。',
      lastMessageAt: DateTime.now().subtract(const Duration(minutes: 32)),
    ),
    ConversationSummary(
      id: 'c_brian',
      type: ConversationType.single,
      title: '北辰',
      avatarColorValue: 0xFFF6BD16,
      participantIds: const ['u_me', 'u_brian'],
      lastMessagePreview: '收到，明早同步。',
      lastMessageAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  WalletAccount walletAccount = const WalletAccount(
    userId: 'u_me',
    balance: 1288.88,
    frozenBalance: 88.00,
  );

  final List<WalletTransaction> walletTransactions = [
    WalletTransaction(
      id: 'wt_1',
      type: WalletTransactionType.recharge,
      direction: WalletTransactionDirection.income,
      title: '钱包充值',
      amount: 500.00,
      balanceAfter: 1288.88,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      description: '支付宝 App 支付（Mock）',
    ),
    WalletTransaction(
      id: 'wt_2',
      type: WalletTransactionType.freeze,
      direction: WalletTransactionDirection.freeze,
      title: '红包冻结',
      amount: 88.00,
      balanceAfter: 788.88,
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      description: '产品设计群拼手气红包',
    ),
    WalletTransaction(
      id: 'wt_3',
      type: WalletTransactionType.redPacketReceive,
      direction: WalletTransactionDirection.income,
      title: '收到红包',
      amount: 28.80,
      balanceAfter: 876.88,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      description: '安安的单聊红包',
    ),
  ];

  final List<RedPacketRecord> redPackets = [
    RedPacketRecord(
      id: 'rp_1',
      type: RedPacketType.groupRandom,
      targetName: '产品设计群',
      amount: 88.00,
      greeting: '新版本上线顺利',
      status: RedPacketStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      claimedCount: 2,
      totalCount: 5,
    ),
    RedPacketRecord(
      id: 'rp_2',
      type: RedPacketType.single,
      targetName: '安安',
      amount: 20.00,
      greeting: '辛苦啦',
      status: RedPacketStatus.claimed,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      claimedCount: 1,
      totalCount: 1,
    ),
  ];

  late final Map<String, List<ChatMessage>> messagesByConversation = {
    'c_anna': [
      ChatMessage(
        id: 'm_1',
        conversationId: 'c_anna',
        senderId: 'u_anna',
        kind: MessageKind.text,
        content: '首页聊天列表我已经整理好了。',
        createdAt: DateTime.now().subtract(const Duration(minutes: 24)),
      ),
      ChatMessage(
        id: 'm_2',
        conversationId: 'c_anna',
        senderId: 'u_me',
        kind: MessageKind.text,
        content: '好，我等会儿把我的页一起补上。',
        createdAt: DateTime.now().subtract(const Duration(minutes: 19)),
        isMine: true,
        isRead: true,
      ),
      ChatMessage(
        id: 'm_3',
        conversationId: 'c_anna',
        senderId: 'u_anna',
        kind: MessageKind.text,
        content: '晚上把原型再过一遍。',
        createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
    ],
    'c_group_design': [
      ChatMessage(
        id: 'm_4',
        conversationId: 'c_group_design',
        senderId: 'u_brian',
        kind: MessageKind.text,
        content: '我把新版本流程图更新了。',
        createdAt: DateTime.now().subtract(const Duration(minutes: 50)),
      ),
      ChatMessage(
        id: 'm_5',
        conversationId: 'c_group_design',
        senderId: 'u_cici',
        kind: MessageKind.text,
        content: '聊天页交互按微信风格来，细节会更稳。',
        createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
      ChatMessage(
        id: 'm_6',
        conversationId: 'c_group_design',
        senderId: 'u_me',
        kind: MessageKind.text,
        content: '可以，先把 MVP 页面走通。',
        createdAt: DateTime.now().subtract(const Duration(minutes: 40)),
        isMine: true,
        isRead: true,
      ),
    ],
    'c_brian': [
      ChatMessage(
        id: 'm_7',
        conversationId: 'c_brian',
        senderId: 'u_brian',
        kind: MessageKind.text,
        content: '收到，明早同步。',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ],
  };

  UserProfile userById(String id) {
    if (id == me.id) return me;
    return contacts.firstWhere((user) => user.id == id);
  }
}
