// import 'package:authentication_riverpod/providers/auth_provider.dart';
import 'package:dendro3/presentation/view/user_dispositif_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
