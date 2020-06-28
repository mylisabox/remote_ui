import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:remote_color_picker/src/widgets/color_picker_inline.dart';
import 'package:remote_ui/remote_ui.dart';

class ColorPickerInlineParser extends WidgetParser with ColorHexParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    final color = factory.getData(definition, data, 'value');
    return ColorPickerInline(
      id: definition['id'],
      isOutputHexString: color is String,
      includeAlphaInHexString: color is String && color.length > 7,
      value: definition.containsKey('value') ? Color(parseHex(color)) : Colors.black,
      paletteType: definition.containsKey('paletteType') ? PaletteType.values[definition['paletteType']] : PaletteType.hsv,
      enableAlpha: definition['enableAlpha'] ?? true,
      enableLabel: definition['enableLabel'] ?? true,
      displayThumbColor: definition['displayThumbColor'] ?? false,
      colorPickerWidth: definition['colorPickerWidth'] ?? 300.0,
      pickerAreaHeightPercent: definition['pickerAreaHeightPercent'] ?? 1.0,
    );
  }
}
