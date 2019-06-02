mixin ColorHexParser {
  int parseHex(dynamic hexColor) {
    if (hexColor is String) {
      final hexColorTrim = hexColor.toUpperCase().replaceAll('#', '').replaceAll('0X', '').padLeft(8, 'F');
      return int.parse(hexColorTrim, radix: 16);
    }

    return hexColor;
  }
}
