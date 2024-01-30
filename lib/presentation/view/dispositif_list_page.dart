import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';
// import 'package:dendro3/presentation/view/dispositif_form_page.dart';
import 'package:dendro3/presentation/viewmodel/dispositiflist/filter_kind_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/dispositiflist/dispositif_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DispositifListPage extends StatelessWidget {
  final _filteredDispositifListProvider = filteredDispositifListProvider;
  final _dispositifListProvider = dispositifListViewModelStateNotifierProvider;

  DispositifListPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositif App'),
      ),
      body: Column(
        children: [
          ChipsBarWidget(),
          const Divider(height: 2, color: Colors.grey),
          // Expanded(child: _buildDispositifListWidget(context, dispositifList)),
          Consumer(
            builder: (context, ref, _) {
              return ref.watch(_filteredDispositifListProvider).maybeWhen(
                    success: (content) =>
                        _buildDispositifListContainerWidget(context, content),
                    error: (_) => _buildErrorWidget(),
                    orElse: () => const Expanded(
                        child: Center(child: CircularProgressIndicator())),
                  );
            },
          ),
        ],
      ),
      // floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildDispositifListContainerWidget(
      final BuildContext context, final DispositifList dispositifList) {
    return Expanded(child: _buildDispositifListWidget(context, dispositifList));
  }

  Widget _buildDispositifListWidget(
      final BuildContext context, final DispositifList dispositifList) {
    if (dispositifList.length == 0) {
      return const Center(child: Text('No dispositif'));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: dispositifList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (final BuildContext context, final int index) {
          return _buildDispositifItemCardWidget(context, dispositifList[index]);
        },
      );
    }
  }

  Widget _buildDispositifItemCardWidget(
      final BuildContext context, final Dispositif dispositif) {
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
                      dispositif.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Text(
                    //   DateFormat('yyyy/MM/dd').format(dispositif.dueDate),
                    //   style: Theme.of(context).textTheme.caption,
                    // ),
                    const SizedBox(height: 4),
                    Text(
                      dispositif.idOrganisme.toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      dispositif.alluvial
                          ? 'Ce dispositif est alluvial'
                          : "Ce dispositif n'est pas alluvial",
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
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

  // Widget _buildCheckedIcon(final BuildContext context, final Dispositif dispositif) {
  //   return InkResponse(
  //     child: const Icon(Icons.done, size: 24, color: Colors.lightGreen),
  //     onTap: () => context.read(_dispositifListProvider.notifier).undoDispositif(dispositif),
  //     splashColor: Colors.transparent,
  //   );
  // }

  // Widget _buildUncheckedIcon(final BuildContext context, final Dispositif dispositif) {
  //   return InkResponse(
  //     child: const Icon(Icons.radio_button_off_rounded, size: 24, color: Colors.grey),
  //     onTap: () => context.read(_dispositifListProvider.notifier).completeDispositif(dispositif),
  //     splashColor: Colors.transparent,
  //   );
  // }

  // Widget _buildFloatingActionButton(final BuildContext context) {
  //   return FloatingActionButton(
  //     onPressed: () => Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => const DispositifFormPage(null),
  //       ),
  //     ),
  //     child: const Icon(Icons.add),
  //   );
  // }

  Widget _buildErrorWidget() {
    return const Center(child: Text('An error has occurred!'));
  }
}

class ChipsBarWidget extends StatelessWidget {
  final _provider = filterKindViewModelStateNotifierProvider;

  ChipsBarWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final viewModel = ref.watch(_provider.notifier);
        ref.watch(_provider);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                InputChip(
                  label: const Text('All'),
                  selected: viewModel.isFilteredByAll(),
                  onSelected: (_) => viewModel.filterByAll(),
                  selectedColor:
                      viewModel.isFilteredByAll() ? Colors.lightGreen : null,
                ),
                const SizedBox(width: 8),
                InputChip(
                  label: const Text('Downloaded'),
                  selected: viewModel.isFilteredByDownloaded(),
                  onSelected: (_) => viewModel.filterByUndownloaded(),
                  selectedColor: viewModel.isFilteredByDownloaded()
                      ? Colors.lightGreen
                      : null,
                ),
                const SizedBox(width: 8),
                InputChip(
                  label: const Text('Incomplete'),
                  selected: viewModel.isFilteredByUndownloaded(),
                  onSelected: (_) => viewModel.filterByUndownloaded(),
                  selectedColor: viewModel.isFilteredByUndownloaded()
                      ? Colors.lightGreen
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
