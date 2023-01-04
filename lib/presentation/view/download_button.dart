import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/state/download_status.dart';
import 'package:dendro3/presentation/viewmodel/userDispositifs/user_dispositifs_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class DownloadButton extends HookConsumerWidget {
  const DownloadButton({
    super.key,
    required this.dispInfo,
    // this.downloadProgress = 0.0,
    // required this.onDownload,
    // required this.onCancel,
    // required this.onOpen,
    // this.transitionDuration = const Duration(milliseconds: 500),
  });

  // final DownloadStatus status;
  final DispositifInfo dispInfo;
  // final double downloadProgress;
  // final VoidCallback onDownload;
  // final VoidCallback onCancel;
  // final VoidCallback onOpen;
  final Duration transitionDuration = const Duration(milliseconds: 500);

  bool get _isDownloading =>
      dispInfo.downloadStatus == DownloadStatus.downloading;

  bool get _isFetching =>
      dispInfo.downloadStatus == DownloadStatus.fetchingDownload;

  bool get _isDownloaded =>
      dispInfo.downloadStatus == DownloadStatus.downloaded;

  void _onPressed(WidgetRef ref) {
    // ref.watch(userDispositifListViewModelStateNotifierProvider)
    // ref
    //     .read(userDispositifListViewModelStateNotifierProvider.notifier)
    //     .downloadDispositif(dispInfo);

    switch (dispInfo.downloadStatus) {
      case DownloadStatus.notDownloaded:
        ref
            .read(userDispositifListViewModelStateNotifierProvider.notifier)
            .downloadDispositif(dispInfo);
        // onDownload();
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
            .read(userDispositifListViewModelStateNotifierProvider.notifier)
            .stopDownloadDispositif(dispInfo);
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

    // var _count = ref.watch(currentCount);
    // useValueChanged(_count, (_, __) async {
    //   _controller.forward();
    // });

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              _onPressed(ref);
            },
            child: Stack(
              children: [
                ButtonShapeWidget(
                  transitionDuration: transitionDuration,
                  isDownloaded: _isDownloaded,
                  isDownloading: _isDownloading,
                  isFetching: _isFetching,
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
    required this.transitionDuration,
  });

  final bool isDownloading;
  final bool isDownloaded;
  final bool isFetching;
  final Duration transitionDuration;

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
            isDownloaded ? 'OPEN' : 'GET',
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
