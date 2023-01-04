import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/model/dispositifInfo_list.dart';
import 'package:dendro3/presentation/view/download_button.dart';
import 'package:dendro3/presentation/viewmodel/userDispositifs/user_dispositifs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDispositifList extends ConsumerWidget {
  // <2>
  const UserDispositifList({Key? key}) : super(key: key);

  // @override
  // ConsumerState<UserDispositifList> createState() =>
  //     _UserDispositifListState(); // <3>
// }

// class _UserDispositifListState extends ConsumerState<UserDispositifList> {
  // <4>
  // late DispositifList fistDispList;

  // @override
  // void initState() {
  //   super.initState();

  //   // _downloadControllers = List<DownloadController>.generate(
  //   //   20,
  //   //   (index) => SimulatedDownloadController(onOpenDownload: () {
  //   //     _openDownload(index);
  //   //   }),
  //   // );

  //   // fistDispList = ref.read(userDispositifListViewModelStateNotifierProvider); // <5>
  // }

  // void _openDownload(int index) {e
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Open App ${index + 1}'),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _userDispositifListProvider = ref.watch(userDispositifListProvider);
    final userDispositifList =
        ref.watch(userDispositifListViewModelStateNotifierProvider);

    // final modelList = ref.watch(containerListProvider);

    // return
    // Expanded(
    // child: const Text('Uh o'),
    // child:
    return _userDispositifListProvider.maybeWhen(
      success: (data) => _buildDispositifListWidget(context, data),
      // success: (data) => const Text('Uh oh... Something went wrong...',
      //     style: TextStyle(color: Colors.white)),

      error: (_) => const Center(
        child: Text('Uh oh... Something went wrong...',
            style: TextStyle(color: Colors.white)),
      ),
      orElse: () =>
          const Expanded(child: Center(child: CircularProgressIndicator())),

      // data: (data) => _buildDispositifListWidget(context, data),
      // loading: () => const Center(child: CircularProgressIndicator()),
      // error: (error, _) => const Center(
      //   child: Text('Uh oh... Something went wrong...',
      //       style: TextStyle(color: Colors.white)),
      // ),
      // ),
    );
  }

  Widget _buildDispositifListWidget(
      final BuildContext context, final DispositifInfoList dispositifInfoList) {
    if (dispositifInfoList.length == 0) {
      return const Center(child: Text('No dispositif'));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: dispositifInfoList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (final BuildContext context, final int index) {
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
    // required this.context,
    required this.dispositifInfo,
  }) : super(key: key);
  // Widget _buildDispositifItemCardWidget(
  // final BuildContext context, final Dispositif dispositif,final Model this.model) {

  // final downloadController = _downloadControllers[index];
  // final Model model;
  final DispositifInfo dispositifInfo;
  // final BuildContext context;

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
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Text(
                    //   DateFormat('yyyy/MM/dd').format(dispositif.dueDate),
                    //   style: Theme.of(context).textTheme.caption,
                    // ),
                    const SizedBox(height: 4),
                    Text(
                      dispositifInfo.dispositif.idOrganisme.toString(),
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      dispositifInfo.dispositif.alluvial
                          ? 'Ce dispositif est alluvial'
                          : "Ce dispositif n'est pas alluvial",
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // IconButton(
              //   iconSize: 72,
              //   icon: Icon(Icons.favorite),
              //   onPressed: () {
              //     ref
              //         .read(userDispositifListViewModelStateNotifierProvider
              //             .notifier)
              //         .downloadData(3);
              //     // userDispositifList.downloadData();
              //   },
              // ),
              SizedBox(
                width: 96,
                child: DownloadButton(dispInfo: dispositifInfo),
                // AnimatedBuilder(
                //   animation: downloadController,
                //   builder: (context, child) {
                //     return DownloadButton(
                //       status: downloadController.downloadStatus,
                //       downloadProgress: downloadController.progress,
                //       onDownload: downloadController.startDownload,
                //       onCancel: downloadController.stopDownload,
                //       onOpen: downloadController.openDownload,
                //     );
                //   },
                // ),
              ),
              // const SizedBox(width: 8),
              // dispositif.isCompleted ? _buildCheckedIcon(context, dispositif) : _buildUncheckedIcon(context, dispositif),
            ],
          ),
        ),
      ),
      // onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => DispositifFormPage(dispositif),
      //     )),
    );
  }
}
