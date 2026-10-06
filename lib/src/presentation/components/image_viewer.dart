import 'dart:io';

import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'components.dart';

void showFullScreenNetworkImage(BuildContext context, String imageUrl) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) =>
        _ImageViewer(image: imageUrl),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final opacity = CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 1.0 / 3.0),
      );

      final position = Tween(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.ease));

      return FadeTransition(
        opacity: opacity,
        child: SlideTransition(position: position, child: child),
      );
    },
  );
}

void showFullScreenLocalImage(BuildContext context, String imagePath) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) =>
        _ImageViewer.local(image: imagePath),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final opacity = CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 1.0 / 3.0),
      );

      final position = Tween(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.ease));

      return FadeTransition(
        opacity: opacity,
        child: SlideTransition(position: position, child: child),
      );
    },
  );
}

enum _FileType { local, network }

class _ImageViewer extends StatelessWidget {
  const _ImageViewer({required this.image}) : _type = _FileType.network;

  const _ImageViewer.local({required this.image}) : _type = _FileType.local;

  final String image;
  final _FileType _type;

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider = switch (_type) {
      _FileType.local => ExtendedFileImageProvider(File(image)),
      _FileType.network => ExtendedNetworkImageProvider(
        image,
        cache: true,
        cacheMaxAge: const Duration(days: 7),
      ),
    };

    Widget child = ExtendedImage(
      image: imageProvider,
      alignment: Alignment.center,
      fit: BoxFit.contain,
      enableLoadState: true,
      mode: ExtendedImageMode.gesture,
      initGestureConfigHandler: (state) {
        return GestureConfig(
          minScale: 1.0,
          maxScale: 4.0,
          animationMinScale: 1.0,
          animationMaxScale: 4.0,
          cacheGesture: true,
        );
      },
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return const Center(child: LoadingIndicator());
          case LoadState.failed:
            return const Center(
              child: SafeArea(
                minimum: EdgeInsets.all(Spacing.normal),
                child: EmptyDataView(
                  icon: Icon(Icons.error_outline_outlined, size: 64),
                  title: 'Unable to load file',
                  description:
                      'We couldn’t load the file. Please check again later.',
                ),
              ),
            );
          case LoadState.completed:
            return state.completedWidget;
        }
      },
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        leading: const CloseButton(),
      ),
      body: SafeArea(child: SizedBox.expand(child: child)),
    );
  }
}
