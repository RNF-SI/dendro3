import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/presentation/viewmodel/auth/auth_viewmodel.dart';
import 'package:dendro3/presentation/view/home_page.dart';
import 'package:dendro3/presentation/view/error_screen.dart';
import 'package:dendro3/presentation/view/loading_screen.dart';
import 'package:dendro3/presentation/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
});

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final authState = ref.watch(authStateProvider);

    return isLoggedIn.when(
      data: (isLoggedInValue) {
        return authState.when(
          data: (user) {
            if (isLoggedInValue && user != null) {
              return const HomePage();
            }
            return LoginPage();
          },
          loading: () => const LoadingScreen(),
          error: (e, trace) => ErrorScreen(e),
        );
      },
      loading: () => const LoadingScreen(),
      error: (e, trace) => ErrorScreen(e),
    );
  }
}
