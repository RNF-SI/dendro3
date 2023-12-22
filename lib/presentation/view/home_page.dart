// import 'package:authentication_riverpod/providers/auth_provider.dart';
import 'package:dendro3/presentation/view/login_page.dart';
import 'package:dendro3/presentation/view/user_dispositif_list.dart';
import 'package:dendro3/presentation/viewmodel/auth/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.read(authenticationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Dispositifs"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authViewModel.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            UserDispositifList(),
          ],
        ),
      ),
    );
  }
}
