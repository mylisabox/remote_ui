import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Widget createImageSvg({
  String url,
  double width,
  double height,
  BoxFit fit,
}) {
  return ImageSvgWeb(
    url: url,
    width: width,
    height: height,
    fit: fit,
  );
}

class ImageSvgWeb extends HookWidget {
  final String url;
  final double height;
  final double width;
  final BoxFit fit;

  const ImageSvgWeb({Key key, this.url, this.height, this.width, this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = useMemoized(() => UniqueKey().toString());

    useEffect(() {
      ui.platformViewRegistry.registerViewFactory('img-svg-$id', (int viewId) {
        final element = ImageElement(src: url, height: height.toInt(), width: width.toInt());
        return element;
      });
      return () {};
    }, const []);

    return HtmlElementView(
      viewType: 'img-svg-$id',
    );
  }
}
