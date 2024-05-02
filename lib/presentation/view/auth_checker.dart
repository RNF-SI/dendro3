import 'package:dendro3/domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/presentation/viewmodel/auth/auth_viewmodel.dart';
import 'package:dendro3/presentation/view/home_page.dart';
import 'package:dendro3/presentation/view/error_screen.dart';
import 'package:dendro3/presentation/view/loading_screen.dart';
import 'package:dendro3/presentation/view/login_page.dart';

final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final usecase = ref.read(getIsLoggedInFromLocalStorageUseCaseProvider);
  return await usecase.execute();
});

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return isLoggedIn.when(
      data: (isLoggedInValue) {
        if (isLoggedInValue) {
          return const HomePage();
        } else {
          return LoginPage();
        }
      },
      loading: () => const LoadingScreen(),
      error: (e, trace) => ErrorScreen(e.toString()),
    );
  }
}
