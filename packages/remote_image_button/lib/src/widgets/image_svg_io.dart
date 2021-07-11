import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget createImageSvg({
  required String url,
  double? width,
  double? height,
  required BoxFit fit,
}) {
  return ImageSvgIo(
    url: url,
    width: width,
    height: height,
    fit: fit,
  );
}

class ImageSvgIo extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BoxFit fit;

  const ImageSvgIo({Key? key, required this.url, this.height, this.width, required this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      url,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
