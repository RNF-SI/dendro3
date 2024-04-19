import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/state/download_status.dart';
import 'package:dendro3/presentation/view/dispositif_page.dart';
import 'package:dendro3/presentation/viewmodel/cor_cycle_placette_local_storage_provider.dart';
import 'package:dendro3/presentation/viewmodel/userDispositifs/user_dispositifs_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Custom Colors
const Color colorBlue1 = Color(0xFF598979); // Bleu
const Color colorGreen = Color(0xFF8AAC3E); // Vert
const Color colorBlue2 = Color(0xFF7DAB9C); // Bleu
const Color colorBlack = Color(0xFF1a1a18); // Noir
const Color colorBeige = Color(0xFFF4F1E4); // Beige
const Color colorBrown = Color(0xFF8B5500); // Marron

@immutable
class DownloadButton extends HookConsumerWidget {
  const DownloadButton({
    super.key,
    required this.dispInfo,
  });

  final DispositifInfo dispInfo;
  final Duration transitionDuration = const Duration(milliseconds: 500);

  bool get _isDownloading =>
      dispInfo.downloadStatus == DownloadStatus.downloading;

  bool get _isFetching =>
      dispInfo.downloadStatus == DownloadStatus.fetchingDownload;

  bool get _isDownloaded =>
      dispInfo.downloadStatus == DownloadStatus.downloaded;

  bool get _isRemoving => dispInfo.downloadStatus == DownloadStatus.removing;

  void _onPressed(BuildContext context, WidgetRef ref) async {
    try {
      switch (dispInfo.downloadStatus) {
        case DownloadStatus.notDownloaded:
          ref
              .read(userDispositifListViewModelStateNotifierProvider.notifier)
              .downloadDispositif(dispInfo, context);
          break;
        case DownloadStatus.fetchingDownload:
          // do nothing.
          break;
        case DownloadStatus.downloading:
          ref
              .read(userDispositifListViewModelStateNotifierProvider.notifier)
              .stopDownloadDispositif(dispInfo);
          break;
        case DownloadStatus.downloaded:
          ref
              .read(corCyclePlacetteLocalStorageStatusStateNotifierProvider
                  .notifier)
              .reinitializeList();
          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return DispositifPage(
                dispInfo: dispInfo,
              );
            },
          ));
          break;
        case DownloadStatus.removing:
          // Handle the removing state, perhaps do nothing or show a message
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Download failed: No internet connection."),
      ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(duration: transitionDuration);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });

    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              _onPressed(context, ref);
            },
            child: Stack(
              children: [
                ButtonShapeWidget(
                  transitionDuration: transitionDuration,
                  isDownloaded: _isDownloaded,
                  isDownloading: _isDownloading,
                  isFetching: _isFetching,
                  isRemoving: _isRemoving,
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: transitionDuration,
                    opacity: _isDownloading || _isFetching ? 1.0 : 0.0,
                    curve: Curves.ease,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ProgressIndicatorWidget(
                          isDownloading: _isDownloading,
                          isFetching: _isFetching,
                        ),
                        if (_isDownloading)
                          const Icon(
                            Icons.stop,
                            size: 14,
                            color: colorGreen,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

@immutable
class ButtonShapeWidget extends StatelessWidget {
  const ButtonShapeWidget({
    super.key,
    required this.isDownloading,
    required this.isDownloaded,
    required this.isFetching,
    required this.isRemoving,
    required this.transitionDuration,
  });

  final bool isDownloading;
  final bool isDownloaded;
  final bool isFetching;
  final Duration transitionDuration;
  final bool isRemoving;

  @override
  Widget build(BuildContext context) {
    var shape = ShapeDecoration(
      shape: StadiumBorder(),
      color: isDownloaded ? colorBlue1 : colorBeige,
    );

    if (isDownloading || isFetching) {
      shape = ShapeDecoration(
        shape: CircleBorder(),
        color: Colors.white.withOpacity(0.7),
      );
    }

    String buttonText = isDownloaded ? 'OPEN' : 'GET';
    if (isRemoving) {
      buttonText = 'REMOVING...'; // New text for the removing state
    }

    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.ease,
      width: double.infinity,
      decoration: shape,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: AnimatedOpacity(
          duration: transitionDuration,
          opacity: isDownloading || isFetching ? 0.0 : 1.0,
          curve: Curves.ease,
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDownloading ? colorGreen : colorBlack,
                ),
          ),
        ),
      ),
    );
  }
}

@immutable
class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    super.key,
    required this.isDownloading,
    required this.isFetching,
  });

  final bool isDownloading;
  final bool isFetching;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: CircularProgressIndicator(
          backgroundColor: colorBeige,
          valueColor: AlwaysStoppedAnimation(
            isFetching ? colorBlue1 : colorGreen,
          ),
          strokeWidth: 2,
        ));
  }
}
