class UserProfile {
  const UserProfile({
    required this.id,
    required this.nickname,
    required this.mobile,
    required this.bio,
    required this.avatarColorValue,
    this.isOnline = false,
  });

  final String id;
  final String nickname;
  final String mobile;
  final String bio;
  final int avatarColorValue;
  final bool isOnline;

  String get initials {
    if (nickname.isEmpty) return '?';
    return nickname.substring(0, 1).toUpperCase();
  }

  UserProfile copyWith({
    String? id,
    String? nickname,
    String? mobile,
    String? bio,
    int? avatarColorValue,
    bool? isOnline,
  }) {
    return UserProfile(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      mobile: mobile ?? this.mobile,
      bio: bio ?? this.bio,
      avatarColorValue: avatarColorValue ?? this.avatarColorValue,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
