import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/hsv_picker.dart';
import 'package:remote_color_picker/src/widgets/color_picker.dart';
import 'package:remote_ui/remote_ui.dart';

class ColorPickerParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return ColorPicker(
      id: definition['id'],
      value: definition.containsKey('value') ? Color(factory.getData(definition, data, 'value')) : Colors.black,
      buttonWidth: definition['buttonWidth'] ?? 50,
      buttonHeight: definition['buttonHeight'] ?? 50,
      paletteType: definition.containsKey('paletteType') ? PaletteType.values[definition['paletteType']] : PaletteType.hsv,
      enableAlpha: definition['enableAlpha'] ?? true,
      enableLabel: definition['enableLabel'] ?? true,
      displayThumbColor: definition['displayThumbColor'] ?? false,
      colorPickerWidth: definition['colorPickerWidth'] ?? 300.0,
      pickerAreaHeightPercent: definition['pickerAreaHeightPercent'] ?? 1.0,
    );
  }
}
