import 'package:flutter/cupertino.dart';

import '../app.dart';
import '../models/red_packet.dart';
import '../theme/app_theme.dart';
import '../widgets/inset_section.dart';

class RedPacketRecordsPage extends StatelessWidget {
  const RedPacketRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('红包记录')),
      child: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, _) {
            final items = appState.redPackets;
            return ListView(
              padding: const EdgeInsets.only(top: 14, bottom: 24),
              children: [
                InsetSection(
                  children: items.map((item) => _RecordTile(item: item)).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RecordTile extends StatelessWidget {
  const _RecordTile({required this.item});

  final RedPacketRecord item;

  @override
  Widget build(BuildContext context) {
    return InsetTile(
      leading: _PacketIcon(status: item.status),
      title: item.targetName,
      subtitle: '${_typeLabel(item.type)} · ${item.greeting}\n${_statusLabel(item)}',
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '¥ ${item.amount.toStringAsFixed(2)}',
            style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(_timeLabel(item.createdAt), style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  String _typeLabel(RedPacketType type) {
    switch (type) {
      case RedPacketType.single:
        return '单聊红包';
      case RedPacketType.groupFixed:
        return '群普通红包';
      case RedPacketType.groupRandom:
        return '群拼手气红包';
    }
  }

  String _statusLabel(RedPacketRecord item) {
    switch (item.status) {
      case RedPacketStatus.pending:
        return '待领取 ${item.claimedCount}/${item.totalCount}';
      case RedPacketStatus.claimed:
        return '已领取完成';
      case RedPacketStatus.expired:
        return '已过期退回';
    }
  }

  String _timeLabel(DateTime time) {
    return '${time.month}/${time.day} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class _PacketIcon extends StatelessWidget {
  const _PacketIcon({required this.status});

  final RedPacketStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      RedPacketStatus.pending => const Color(0xFFE8684A),
      RedPacketStatus.claimed => AppTheme.brandGreen,
      RedPacketStatus.expired => AppTheme.textSecondary,
    };

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Icon(CupertinoIcons.gift_fill, color: color, size: 22),
    );
  }
}
