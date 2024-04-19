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
        color: Color(0xFF8AAC3E), // Brand green color for the indicator
        onRefresh: () async {
          ref
              .read(userDispositifListViewModelStateNotifierProvider.notifier)
              .refreshDispositifs();
        },
        child: _buildDispositifListWidget(context, data),
      ),
      error: (_) => const Center(
        child: Text(
          'Uh oh... Something went wrong...',
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
      orElse: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildDispositifListWidget(
      BuildContext context, DispositifInfoList dispositifInfoList) {
    if (dispositifInfoList.isEmpty()) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Pas de dispositifs',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Color(0xFF598979)), // Using brand blue
              ),
            ),
          ),
        ],
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: dispositifInfoList.length,
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
      onTap: () {}, // Add onTap functionality if needed
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dispositifInfo.dispositif.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Color(0xFF598979)), // Brand blue
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dispositifInfo.dispositif.idOrganisme.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Color(0xFF1a1a18)), // Brand dark
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      dispositifInfo.dispositif.alluvial
                          ? 'Ce dispositif est alluvial'
                          : "Ce dispositif n'est pas alluvial",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Color(0xFF8AAC3E)), // Brand green
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
