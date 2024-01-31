// import 'package:authentication_riverpod/providers/auth_provider.dart';
import 'package:dendro3/presentation/view/login_page.dart';
import 'package:dendro3/presentation/view/user_dispositif_list.dart';
import 'package:dendro3/presentation/viewmodel/auth/auth_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/database/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.read(authenticationViewModelProvider);
    final databaseService = ref.read(databaseServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Dispositifs"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm'),
                      content: const Text(
                          'Etes vous sûr de vouloir supprimer la base de données?'),
                      actions: [
                        TextButton(
                          child: const Text('Annuler'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TextButton(
                          child: const Text('Supprimer'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    ),
                  ) ??
                  false;

              if (confirm) {
                try {
                  await databaseService.deleteDatabase();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('La base de données a été supprimée avec succès'),
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Erreur lors de la suppression de la base de données: $e'),
                  ));
                }
              }
            },
          ),
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
      body: const SafeArea(
        child: UserDispositifList(),
      ),
      // SafeArea(
      //   child: Column(
      //     children: const [
      //       Expanded(
      //         child: UserDispositifList(),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
