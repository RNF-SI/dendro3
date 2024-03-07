import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/model/dispositifInfo_list.dart';
import 'package:dendro3/presentation/view/download_button.dart';
import 'package:dendro3/presentation/viewmodel/userDispositifs/user_dispositifs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDispositifList extends ConsumerWidget {
  const UserDispositifList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDispositifListProv = ref.watch(userDispositifListProvider);
    final userDispositifList =
        ref.watch(userDispositifListViewModelStateNotifierProvider);

    return userDispositifListProv.maybeWhen(
      success: (data) => RefreshIndicator(
        onRefresh: () async {
          // Trigger the refresh logic
          ref
              .read(userDispositifListViewModelStateNotifierProvider.notifier)
              .refreshDispositifs();
        },
        child: _buildDispositifListWidget(context, data),
      ),
      error: (_) => const Center(
        child: Text('Uh oh... Something went wrong...',
            style: TextStyle(color: Colors.white)),
      ),
      orElse: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildDispositifListWidget(
      BuildContext context, DispositifInfoList dispositifInfoList) {
    if (dispositifInfoList.length == 0) {
      // Wrap the 'No dispositif' message in a ListView to keep pull-to-refresh functionality
      return ListView(
        physics:
            const AlwaysScrollableScrollPhysics(), // This is important for enabling pull-to-refresh
        children: const [
          Center(
            child: Padding(
              padding:
                  EdgeInsets.all(16.0), // Add some padding around the message
              child: Text('Pas de dispositifs', textAlign: TextAlign.center),
            ),
          ),
        ],
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: dispositifInfoList.length,
        physics:
            const AlwaysScrollableScrollPhysics(), // Keeps pull-to-refresh enabled
        itemBuilder: (BuildContext context, int index) {
          return DispositifItemCardWidget(
              dispositifInfo: dispositifInfoList[index]);
        },
      );
    }
  }
}

class DispositifItemCardWidget extends ConsumerWidget {
  const DispositifItemCardWidget({
    Key? key,
    required this.dispositifInfo,
  }) : super(key: key);

  final DispositifInfo dispositifInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dispositifInfo.dispositif.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dispositifInfo.dispositif.idOrganisme.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      dispositifInfo.dispositif.alluvial
                          ? 'Ce dispositif est alluvial'
                          : "Ce dispositif n'est pas alluvial",
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 96,
                child: DownloadButton(dispInfo: dispositifInfo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
