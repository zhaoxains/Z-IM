enum RedPacketType { single, groupFixed, groupRandom }

enum RedPacketStatus { pending, claimed, expired }

class RedPacketRecord {
  const RedPacketRecord({
    required this.id,
    required this.type,
    required this.targetName,
    required this.amount,
    required this.greeting,
    required this.status,
    required this.createdAt,
    this.claimedCount = 0,
    this.totalCount = 1,
  });

  final String id;
  final RedPacketType type;
  final String targetName;
  final double amount;
  final String greeting;
  final RedPacketStatus status;
  final DateTime createdAt;
  final int claimedCount;
  final int totalCount;

  RedPacketRecord copyWith({
    String? id,
    RedPacketType? type,
    String? targetName,
    double? amount,
    String? greeting,
    RedPacketStatus? status,
    DateTime? createdAt,
    int? claimedCount,
    int? totalCount,
  }) {
    return RedPacketRecord(
      id: id ?? this.id,
      type: type ?? this.type,
      targetName: targetName ?? this.targetName,
      amount: amount ?? this.amount,
      greeting: greeting ?? this.greeting,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      claimedCount: claimedCount ?? this.claimedCount,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
