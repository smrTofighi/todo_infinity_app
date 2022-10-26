/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ariplan.png
  AssetGenImage get ariplan => const AssetGenImage('assets/icons/ariplan.png');

  /// File path: assets/icons/arrow-left.png
  AssetGenImage get arrowLeft =>
      const AssetGenImage('assets/icons/arrow-left.png');

  /// File path: assets/icons/arrow-right.png
  AssetGenImage get arrowRight =>
      const AssetGenImage('assets/icons/arrow-right.png');

  /// File path: assets/icons/book.png
  AssetGenImage get book => const AssetGenImage('assets/icons/book.png');

  /// File path: assets/icons/dream.png
  AssetGenImage get dream => const AssetGenImage('assets/icons/dream.png');

  /// File path: assets/icons/home.png
  AssetGenImage get home => const AssetGenImage('assets/icons/home.png');

  /// File path: assets/icons/menu-dot_vertical.png
  AssetGenImage get menuDotVertical =>
      const AssetGenImage('assets/icons/menu-dot_vertical.png');

  /// File path: assets/icons/menu.png
  AssetGenImage get menu => const AssetGenImage('assets/icons/menu.png');

  /// File path: assets/icons/music.png
  AssetGenImage get music => const AssetGenImage('assets/icons/music.png');

  /// File path: assets/icons/notebook.png
  AssetGenImage get notebook =>
      const AssetGenImage('assets/icons/notebook.png');

  /// File path: assets/icons/notification.png
  AssetGenImage get notification =>
      const AssetGenImage('assets/icons/notification.png');

  /// File path: assets/icons/school.png
  AssetGenImage get school => const AssetGenImage('assets/icons/school.png');

  /// File path: assets/icons/search.png
  AssetGenImage get search => const AssetGenImage('assets/icons/search.png');

  /// File path: assets/icons/settings.png
  AssetGenImage get settings =>
      const AssetGenImage('assets/icons/settings.png');

  /// File path: assets/icons/share.png
  AssetGenImage get share => const AssetGenImage('assets/icons/share.png');

  /// File path: assets/icons/shop.png
  AssetGenImage get shop => const AssetGenImage('assets/icons/shop.png');

  /// File path: assets/icons/sign-out.png
  AssetGenImage get signOut => const AssetGenImage('assets/icons/sign-out.png');

  /// File path: assets/icons/user.png
  AssetGenImage get user => const AssetGenImage('assets/icons/user.png');

  /// File path: assets/icons/work.png
  AssetGenImage get work => const AssetGenImage('assets/icons/work.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        ariplan,
        arrowLeft,
        arrowRight,
        book,
        dream,
        home,
        menuDotVertical,
        menu,
        music,
        notebook,
        notification,
        school,
        search,
        settings,
        share,
        shop,
        signOut,
        user,
        work
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
