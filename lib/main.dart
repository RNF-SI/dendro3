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
      theme: ThemeData(
        primaryColor: Color(0xFF598979), // Used for elements needing emphasis
        scaffoldBackgroundColor:
            Color(0xFFF4F1E4), // Background color for Scaffold widgets
        appBarTheme: AppBarTheme(
          color: Color(0xFF598979), // Custom color for AppBar
          toolbarTextStyle: TextStyle(
              color: Colors.white, fontSize: 18), // Simplified text style
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF8B5500),
            backgroundColor: Color(0xFF8AAC3E), // Button background color
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)), // Rounded buttons
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF7DAB9C), // Icon color
        ),
        textTheme: TextTheme(
          bodyText1:
              TextStyle(color: Color(0xFF1a1a18)), // General text styling
          bodyText2: TextStyle(color: Color(0xFF1a1a18)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor:
                Color(0xFF8AAC3E), // Text color for elevated buttons
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Color(0xFF8AAC3E)),
      ),
    );
  }
}
