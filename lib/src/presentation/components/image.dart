import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'shimmer.dart';

class ImageFromAsset extends StatelessWidget {
  const ImageFromAsset(
    this.image, {
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.matchTextDirection = true,
    this.package,
    super.key,
  });

  const ImageFromAsset.square(
    this.image, {
    double size = 24,
    this.color,
    this.fit = BoxFit.contain,
    this.matchTextDirection = true,
    this.package,
    super.key,
  }) : height = size,
       width = size;
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;
  final bool matchTextDirection;
  final String? package;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: fit,
      color: color,
      width: width,
      height: height,
      matchTextDirection: matchTextDirection,
      package: package,
    );
  }
}

class SvgImageFromAsset extends StatelessWidget {
  const SvgImageFromAsset(
    this.image, {
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.package,
    this.matchTextDirection = true,
    this.alignment,
    super.key,
  });

  const SvgImageFromAsset.square(
    this.image, {
    double size = 24,
    this.color,
    this.fit = BoxFit.contain,
    this.matchTextDirection = true,
    this.package,
    this.alignment,
    super.key,
  }) : height = size,
       width = size;

  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;
  final bool matchTextDirection;
  final String? package;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      fit: fit,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color!, BlendMode.srcIn),
      width: width,
      height: height,
      matchTextDirection: matchTextDirection,
      package: package,
      alignment: alignment ?? Alignment.center,
    );
  }
}

class NetworkImageBuilder extends StatelessWidget {
  const NetworkImageBuilder({
    super.key,
    required this.imageUrl,
    required this.placeholderBuilder,
    this.loadingBuilder,
    this.fit,
    this.elevation,
    this.height,
    this.width,
    this.onPressed,
    this.onLongPressed,
    this.shape,
    this.borderRadius,
  });

  const NetworkImageBuilder.square({
    super.key,
    required this.imageUrl,
    required this.placeholderBuilder,
    this.loadingBuilder,
    this.fit,
    this.elevation,
    this.onPressed,
    this.onLongPressed,
    this.borderRadius,
    double size = 48,
  }) : height = size,
       width = size,
       shape = BoxShape.rectangle;

  const NetworkImageBuilder.circle({
    super.key,
    required this.imageUrl,
    required this.placeholderBuilder,
    this.loadingBuilder,
    this.fit,
    this.elevation,
    this.onPressed,
    this.onLongPressed,
    double size = 48,
  }) : height = size,
       width = size,
       shape = BoxShape.circle,
       borderRadius = null;

  final String? imageUrl;
  final BoxFit? fit;
  final double? elevation;
  final double? height;
  final double? width;
  final WidgetBuilder placeholderBuilder;
  final WidgetBuilder? loadingBuilder;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final BoxShape? shape;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final imageUrl = this.imageUrl ?? '';

    final effectiveShape = shape ?? BoxShape.rectangle;
    final effectiveBorderRadius = effectiveShape == BoxShape.circle
        ? null
        : borderRadius;
    final effectiveShapeBorder = switch (effectiveShape) {
      BoxShape.rectangle => RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius ?? BorderRadius.zero,
      ),
      BoxShape.circle => const CircleBorder(),
    };

    Widget child = Visibility(
      visible: imageUrl.isNotEmpty,
      replacement: Container(
        height: height,
        width: width,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: ShapeDecoration(shape: effectiveShapeBorder),
        child: Builder(builder: placeholderBuilder),
      ),
      child: ExtendedImage.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        shape: effectiveShape,
        borderRadius: effectiveBorderRadius,
        enableLoadState: true,
        clearMemoryCacheWhenDispose: false,
        cacheMaxAge: const Duration(days: 7),
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              if (loadingBuilder != null) {
                return Builder(builder: loadingBuilder!);
              }
              return const CommonShimmer(child: Material());
            case LoadState.failed:
              return Builder(builder: placeholderBuilder);
            case LoadState.completed:
              return state.completedWidget;
          }
        },
      ),
    );

    if (onPressed != null || onLongPressed != null) {
      child = GestureDetector(
        onTap: onPressed,
        onLongPress: onLongPressed,
        child: child,
      );
    }

    return Material(
      elevation: elevation ?? 0,
      type: MaterialType.canvas,
      shape: effectiveShapeBorder,
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
