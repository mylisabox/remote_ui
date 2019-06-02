import 'dart:ui';

mixin ColorHexParser {
  int parseHex(dynamic hexColor) {
    if (hexColor is String) {
      final hexColorTrim = hexColor.toUpperCase().replaceAll('#', '').replaceAll('0X', '').padLeft(8, 'F');
      return int.parse(hexColorTrim, radix: 16);
    }

    return hexColor;
  }
}

mixin ColorToHex {
  String toHex(Color color, bool includeAlpha) {
    final hex = '#${color.value.toRadixString(16)}';
    if (includeAlpha) {
      return hex;
    }
    return hex.replaceFirst('#ff', '#');
  }
}
