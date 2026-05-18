import 'package:flutter/material.dart';

import '../app.dart';
import '../theme/app_theme.dart';
import 'contacts_page.dart';
import 'messages_page.dart';
import 'mine_page.dart';

class HomeShellPage extends StatefulWidget {
  const HomeShellPage({super.key});

  @override
  State<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeShellPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const MessagesPage(),
      const ContactsPage(),
      const MinePage(),
    ];

    final titles = ['消息', '通讯录', '我的'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
        actions: [
          if (_currentIndex == 2)
            IconButton(
              onPressed: appState.logout,
              icon: const Icon(Icons.logout_rounded),
            ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        indicatorColor: AppTheme.brandGreen.withOpacity(0.14),
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: '消息'),
          NavigationDestination(icon: Icon(Icons.perm_contact_calendar_outlined), label: '通讯录'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: '我的'),
        ],
      ),
    );
  }
}
