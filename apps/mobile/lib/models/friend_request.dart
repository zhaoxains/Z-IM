enum FriendRequestStatus { pending, accepted, rejected }

class FriendRequest {
  const FriendRequest({
    required this.id,
    required this.fromUserId,
    required this.message,
    required this.createdAt,
    this.status = FriendRequestStatus.pending,
  });

  final String id;
  final String fromUserId;
  final String message;
  final DateTime createdAt;
  final FriendRequestStatus status;

  FriendRequest copyWith({
    String? id,
    String? fromUserId,
    String? message,
    DateTime? createdAt,
    FriendRequestStatus? status,
  }) {
    return FriendRequest(
      id: id ?? this.id,
      fromUserId: fromUserId ?? this.fromUserId,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
