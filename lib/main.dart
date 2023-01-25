import 'package:dendro3/presentation/view/auth_checker.dart';
import 'package:dendro3/presentation/view/dispositif_page.dart';
import 'package:dendro3/presentation/view/home_page.dart';
import 'package:dendro3/presentation/view/login_page.dart';
import 'package:dendro3/presentation/view/user_dispositif_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthChecker(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    // GoRoute(
    //   name: 'dispositif',
    //   path: '/dispositif/:dispositifId',
    //   builder: (context, state) => DispositifPage(
    //       dispInfo: state.queryParams['dispositifInfo']!,
    //       dispositifId: int.parse(state.params['dispositifId']!),
    //       dispositifName: state.queryParams['dispositifName']!),
    // ),
    GoRoute(
      name: 'dispositifs',
      path: '/dispositifs',
      builder: (context, state) => const UserDispositifList(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);

void main() {
  runApp(
    ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
