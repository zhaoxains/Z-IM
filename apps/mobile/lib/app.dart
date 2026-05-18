import 'package:flutter/cupertino.dart';

import 'screens/home_shell_page.dart';
import 'screens/login_page.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

final AppState appState = AppState();

class ZimApp extends StatelessWidget {
  const ZimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        return CupertinoApp(
          title: 'Z-IM',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          home: appState.isLoggedIn ? const HomeShellPage() : const LoginPage(),
        );
      },
    );
  }
}
