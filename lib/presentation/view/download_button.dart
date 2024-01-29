import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/state/download_status.dart';
import 'package:dendro3/presentation/view/dispositif_page.dart';
import 'package:dendro3/presentation/viewmodel/cor_cycle_placette_local_storage_provider.dart';
import 'package:dendro3/presentation/viewmodel/userDispositifs/user_dispositifs_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class DownloadButton extends HookConsumerWidget {
  const DownloadButton({
    super.key,
    required this.dispInfo,
  });

  // final DownloadStatus status;
  final DispositifInfo dispInfo;
  final Duration transitionDuration = const Duration(milliseconds: 500);

  bool get _isDownloading =>
      dispInfo.downloadStatus == DownloadStatus.downloading;

  bool get _isFetching =>
      dispInfo.downloadStatus == DownloadStatus.fetchingDownload;

  bool get _isDownloaded =>
      dispInfo.downloadStatus == DownloadStatus.downloaded;

  bool get _isRemoving => dispInfo.downloadStatus == DownloadStatus.removing;

  void _onPressed(BuildContext context, WidgetRef ref) {
    switch (dispInfo.downloadStatus) {
      case DownloadStatus.notDownloaded:
        ref
            .read(userDispositifListViewModelStateNotifierProvider.notifier)
            .downloadDispositif(dispInfo);
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
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useAnimationController(duration: transitionDuration);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    return AnimatedBuilder(
        animation: _controller,
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
                          // downloadProgress: downloadProgress,
                          isDownloading: _isDownloading,
                          isFetching: _isFetching,
                        ),
                        if (_isDownloading)
                          const Icon(
                            Icons.stop,
                            size: 14,
                            color: CupertinoColors.activeBlue,
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
    var shape = const ShapeDecoration(
      shape: StadiumBorder(),
      color: CupertinoColors.lightBackgroundGray,
    );

    if (isDownloading || isFetching) {
      shape = ShapeDecoration(
        shape: const CircleBorder(),
        color: Colors.white.withOpacity(0),
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
            style: Theme.of(context).textTheme.button?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.activeBlue,
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
    // required this.downloadProgress,
    required this.isDownloading,
    required this.isFetching,
  });

  // final double downloadProgress;
  final bool isDownloading;
  final bool isFetching;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child:
            // TweenAnimationBuilder<double>(
            // tween: Tween(begin: 0, end: downloadProgress),
            // duration: const Duration(milliseconds: 200),
            // builder: (context, progress, child) {
            // return
            CircularProgressIndicator(
          backgroundColor: isDownloading
              ? CupertinoColors.lightBackgroundGray
              : Colors.white.withOpacity(0),
          valueColor: AlwaysStoppedAnimation(isFetching
              ? CupertinoColors.lightBackgroundGray
              : CupertinoColors.activeBlue),
          strokeWidth: 2,
          // value: isFetching ? null : progress,
        )
        //   },
        // ),
        );
  }
}
