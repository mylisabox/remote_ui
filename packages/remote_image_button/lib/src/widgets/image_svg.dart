import 'package:flutter/material.dart';
import 'package:remote_image_button/src/widgets/image_svg_base.dart';

class ImageSvg extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final BoxFit fit;

  const ImageSvg({Key key, this.url, this.height, this.width, this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return createImageSvg(
      url: url,
      fit: fit,
      height: height,
      width: width,
    );
  }
}
