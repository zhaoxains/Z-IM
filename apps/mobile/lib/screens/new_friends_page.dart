import 'package:flutter/material.dart';

import '../app.dart';
import '../models/friend_request.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar_view.dart';

class NewFriendsPage extends StatelessWidget {
  const NewFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新的朋友')),
      body: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          final requests = appState.friendRequests;
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: requests.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final request = requests[index];
              final user = appState.userById(request.fromUserId);
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AvatarView(label: user.nickname, colorValue: user.avatarColorValue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.nickname, style: const TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 6),
                            Text(request.message, style: const TextStyle(color: AppTheme.textSecondary)),
                            const SizedBox(height: 6),
                            Text(_timeLabel(request), style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildAction(request),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAction(FriendRequest request) {
    if (request.status == FriendRequestStatus.accepted) {
      return const Chip(label: Text('已添加'));
    }
    if (request.status == FriendRequestStatus.rejected) {
      return const Chip(label: Text('已拒绝'));
    }
    return FilledButton.tonal(
      onPressed: () => appState.acceptFriendRequest(request.id),
      child: const Text('通过'),
    );
  }

  String _timeLabel(FriendRequest request) {
    final diff = DateTime.now().difference(request.createdAt);
    if (diff.inHours < 24) {
      return '${diff.inHours} 小时前';
    }
    return '${diff.inDays} 天前';
  }
}
