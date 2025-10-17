import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NetworkImageCached extends StatefulWidget {
  const NetworkImageCached(
      this.imageUrl, {
        super.key,
        this.httpHeaders,
        this.imageBuilder,
        this.placeholder,
        this.progressIndicatorBuilder,
        this.errorWidget,
        this.errorWidgetBuilder,
        this.fadeOutDuration = const Duration(milliseconds: 1000),
        this.fadeOutCurve = Curves.easeOut,
        this.fadeInDuration = const Duration(milliseconds: 500),
        this.fadeInCurve = Curves.easeIn,
        this.width,
        this.height,
        this.fit,
        this.alignment = Alignment.center,
        this.repeat = ImageRepeat.noRepeat,
        this.matchTextDirection = false,
        this.cacheManager,
        this.useOldImageOnUrlChange = false,
        this.color,
        this.filterQuality = FilterQuality.low,
        this.colorBlendMode,
        this.placeholderFadeInDuration,
        this.memCacheWidth,
        this.memCacheHeight,
        this.cacheKey,
        this.maxWidthDiskCache,
        this.maxHeightDiskCache,
        this.errorListener,
        this.shape,
      });

  final BaseCacheManager? cacheManager;
  final String? imageUrl;
  final String? cacheKey;
  final ImageWidgetBuilder? imageBuilder;
  final PlaceholderWidgetBuilder? placeholder;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final LoadingErrorWidgetBuilder? errorWidgetBuilder;
  final Widget? errorWidget;

  final Duration? placeholderFadeInDuration;
  final Duration? fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;

  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final Map<String, String>? httpHeaders;
  final bool useOldImageOnUrlChange;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final ValueChanged<Object>? errorListener;
  final ShapeBorder? shape;

  @override
  State<NetworkImageCached> createState() => _NetworkImageCachedState();
}

class _NetworkImageCachedState extends State<NetworkImageCached>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final errorWidget = widget.errorWidget ?? const NoImagePlaceholder();

    Widget imageWidget;

    if (widget.imageUrl == null || widget.imageUrl!.isEmpty) {
      imageWidget = errorWidget;
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: widget.imageUrl!,
        width: widget.width,
        height: widget.height,
        alignment: widget.alignment,
        color: widget.color,
        cacheKey: widget.cacheKey ?? widget.imageUrl,
        cacheManager: widget.cacheManager,
        colorBlendMode: widget.colorBlendMode,
        matchTextDirection: widget.matchTextDirection,
        maxHeightDiskCache: widget.maxHeightDiskCache,
        maxWidthDiskCache: widget.maxWidthDiskCache,
        memCacheHeight: widget.memCacheHeight,
        memCacheWidth: widget.memCacheWidth,
        fit: widget.fit,
        fadeInCurve: widget.fadeInCurve,
        fadeInDuration: widget.fadeInDuration,
        fadeOutCurve: widget.fadeOutCurve,
        fadeOutDuration: widget.fadeOutDuration,
        filterQuality: widget.filterQuality,
        placeholder: widget.placeholder ??
                (_, __) => Skeletonizer(
              enabled: true,
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
        placeholderFadeInDuration: widget.placeholderFadeInDuration,
        progressIndicatorBuilder: widget.progressIndicatorBuilder,
        useOldImageOnUrlChange: widget.useOldImageOnUrlChange,
        httpHeaders: widget.httpHeaders,
        imageBuilder: widget.imageBuilder,
        errorListener: (_) {},
        errorWidget: widget.errorWidgetBuilder ?? (_, __, ___) => errorWidget,
        repeat: widget.repeat,
      );
    }

    if (widget.shape != null) {
      return ClipPath(
        clipper: ShapeBorderClipper(
          shape: widget.shape!,
          textDirection: Directionality.maybeOf(context),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  @override
  bool get wantKeepAlive => true;
}

class NoImagePlaceholder extends StatelessWidget {
  const NoImagePlaceholder({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Transform.translate(
          offset: const Offset(0, -3),
          child: const Icon(Icons.photo_size_select_actual_outlined),
        ),
      ),
    );
  }
}
