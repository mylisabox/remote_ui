import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/hsv_picker.dart';
import 'package:remote_color_picker/src/utils/mixin.dart';
import 'package:remote_color_picker/src/widgets/color_picker.dart';
import 'package:remote_ui/remote_ui.dart';

class ColorPickerParser extends WidgetParser with ColorHexParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return ColorPicker(
      id: definition['id'],
      value: definition.containsKey('value') ? Color(parseHex(factory.getData(definition, data, 'value'))) : Colors.black,
      buttonWidth: definition['buttonWidth']?.toDouble() ?? 50.0,
      buttonHeight: definition['buttonHeight']?.toDouble() ?? 50.0,
      paletteType: definition.containsKey('paletteType') ? PaletteType.values[definition['paletteType']] : PaletteType.hsv,
      enableAlpha: definition['enableAlpha'] ?? true,
      enableLabel: definition['enableLabel'] ?? true,
      displayThumbColor: definition['displayThumbColor'] ?? false,
      colorPickerWidth: definition['colorPickerWidth']?.toDouble() ?? 300.0,
      pickerAreaHeightPercent: definition['pickerAreaHeightPercent']?.toDouble() ?? 1.0,
    );
  }
}
