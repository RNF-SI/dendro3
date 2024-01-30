import 'package:dendro3/data/repository/local_storage_repository_impl.dart';
import 'package:dendro3/presentation/view/auth_checker.dart';
import 'package:dendro3/presentation/view/home_page.dart';
import 'package:dendro3/presentation/view/login_page.dart';
import 'package:dendro3/presentation/view/user_dispositif_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

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

void main() async {
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageRepositoryImpl.init();
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
