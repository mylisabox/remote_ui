import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/hsv_picker.dart';
import 'package:remote_color_picker/src/utils/mixin.dart';
import 'package:remote_color_picker/src/widgets/color_picker_inline.dart';
import 'package:remote_ui/remote_ui.dart';

class ColorPickerInlineParser extends WidgetParser with ColorHexParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return ColorPickerInline(
      id: definition['id'],
      value: definition.containsKey('value') ? Color(parseHex(factory.getData(definition, data, 'value'))) : Colors.black,
      paletteType: definition.containsKey('paletteType') ? PaletteType.values[definition['paletteType']] : PaletteType.hsv,
      enableAlpha: definition['enableAlpha'] ?? true,
      enableLabel: definition['enableLabel'] ?? true,
      displayThumbColor: definition['displayThumbColor'] ?? false,
      colorPickerWidth: definition['colorPickerWidth'] ?? 300.0,
      pickerAreaHeightPercent: definition['pickerAreaHeightPercent'] ?? 1.0,
    );
  }
}
