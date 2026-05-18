import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../models/friend_request.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar_view.dart';
import '../widgets/inset_section.dart';

class NewFriendsPage extends StatelessWidget {
  const NewFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('新的朋友')),
      child: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, _) {
            final requests = appState.friendRequests;
            return ListView(
              padding: const EdgeInsets.only(top: 14, bottom: 24),
              children: [
                InsetSection(
                  children: requests.map((request) {
                    final user = appState.userById(request.fromUserId);
                    return InsetTile(
                      leading: AvatarView(label: user.nickname, colorValue: user.avatarColorValue),
                      title: user.nickname,
                      subtitle: '${request.message}
${_timeLabel(request)}',
                      trailing: _buildAction(request),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAction(FriendRequest request) {
    if (request.status == FriendRequestStatus.accepted) {
      return const Text('已添加', style: TextStyle(color: AppTheme.brandGreen, fontSize: 13));
    }
    if (request.status == FriendRequestStatus.rejected) {
      return const Text('已拒绝', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13));
    }
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: AppTheme.brandGreen,
      borderRadius: BorderRadius.circular(10),
      minSize: 0,
      onPressed: () => appState.acceptFriendRequest(request.id),
      child: const Text('通过', style: TextStyle(color: CupertinoColors.white, fontSize: 13)),
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
