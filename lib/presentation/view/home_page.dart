import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dendro3/presentation/viewmodel/database/database_service.dart';
import 'dart:io';

import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/presentation/view/login_page.dart';
import 'package:dendro3/presentation/view/user_dispositif_list.dart';
import 'package:dendro3/presentation/viewmodel/auth/auth_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/database/database_service.dart';
import 'package:dendro3/presentation/viewmodel/userDispositifs/user_dispositifs_viewmodel.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.read(authenticationViewModelProvider);
    final databaseService = ref.read(databaseServiceProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showVersionAlert(context);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF598979), // Brand blue
        title: const Text("Mes Dispositifs"),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu), // Menu icon
            onSelected: (value) async {
              switch (value) {
                case 'export':
                  _exportDatabase(context, databaseService);
                  break;
                case 'refresh':
                  ref
                      .read(userDispositifListViewModelStateNotifierProvider
                          .notifier)
                      .refreshDispositifs();
                  await ref
                      .read(setTerminalNameFromLocalStorageUseCaseProvider)
                      .execute();
                  break;
                case 'delete':
                  _confirmDelete(context, databaseService, authViewModel, ref);
                  break;
                case 'version':
                  _showVersionAlert(context);
                  break;
                case 'logout':
                  _confirmSignOut(context, authViewModel, ref);
                  break;
                case 'refreshNomenclatures':
                  await databaseService.refreshNomenclatures();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Nomenclatures mises à jour avec succès')),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'export',
                  child: ListTile(
                    leading: Icon(Icons.save, color: Color(0xFF1a1a18)),
                    title: Text('Exporter la base de données'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'refresh',
                  child: ListTile(
                    leading: Icon(Icons.refresh, color: Color(0xFF1a1a18)),
                    title: Text('Rafraîchir la liste'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Color(0xFF8B5500)),
                    title: Text('Supprimer la base de données'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'version',
                  child: ListTile(
                    leading: Icon(Icons.info_outline, color: Color(0xFF1a1a18)),
                    title: Text('Informations sur la version'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Color(0xFF1a1a18)),
                    title: Text('Déconnexion'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'refreshNomenclatures',
                  child: ListTile(
                    leading: Icon(Icons.sync, color: Color(0xFF1a1a18)),
                    title: Text('Mettre à jour les nomenclatures'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: UserDispositifList(),
      ),
    );
  }

  void _showVersionAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Attention'),
          content: const Text(
              "Attention, cette version de l'application est faite pour qu'un seul mobile soit utilisé par dispositif.\n\nDe plus, la synchronisation ne se fait que dans un sens: Les données sont prises dans le serveur de production et sont envoyées dans un serveur staging après vos saisies.\n\nEn d'autres termes, les modifications faites avec un autre mobile sur une autre placette de votre dispositif ne seront pas visibles sur votre téléphone même après une synchronisation."),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(
    BuildContext context,
    DatabaseService databaseService,
    AuthenticationViewModel authViewModel,
    WidgetRef ref,
  ) async {
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La base de données a été supprimée avec succès'),
          ),
        );

        // Call the refresh function to reload the page or data
        ref
            .read(userDispositifListViewModelStateNotifierProvider.notifier)
            .refreshDispositifs();
        await authViewModel.signOut(ref, context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Erreur lors de la suppression de la base de données: $e'),
          ),
        );
      }
    }
  }

  void _confirmSignOut(BuildContext context,
      AuthenticationViewModel authViewModel, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Deconnexion"),
          content: const Text(
              "Etes vous sûr de vouloir vous déconnecter? Il vous faudra une connexion internet pour vous reconnecter."),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await authViewModel.signOut(ref, context);
              },
              child: const Text("Se Déconnecter"),
            ),
          ],
        );
      },
    );
  }

  void _exportDatabase(
      BuildContext context, DatabaseService databaseService) async {
    bool permissionGranted = await databaseService.requestStoragePermission();
    print('Permission granted: $permissionGranted'); // Temporary log
    if (permissionGranted) {
      try {
        await databaseService.exportDatabase();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'La base de données a été copiée dans un dossier accessible du téléphone'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Erreur lors de la copie de la BDD dans un dossier accessible du téléphone: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permission de stockage non accordée'),
        ),
      );
    }
  }
}
