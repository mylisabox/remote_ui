import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/hsv_picker.dart';
import 'package:remote_color_picker/src/widgets/color_picker.dart';
import 'package:remote_ui/remote_ui.dart';

class ColorPickerParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return ColorPicker(
      id: definition['id'],
      initialValue: definition.containsKey('value') ? Color(definition['value']) : Colors.black,
      buttonWidth: definition['buttonWidth'] ?? 50,
      buttonHeight: definition['buttonHeight'] ?? 50,
      paletteType: definition.containsKey('paletteType') ? PaletteType.values[definition['paletteType']] : PaletteType.hsv,
      enableAlpha: definition.containsKey('enableAlpha') ? definition['enableAlpha']: true,
      enableLabel: definition.containsKey('enableLabel') ?  definition['enableLabel']: true,
      displayThumbColor: definition.containsKey('displayThumbColor') ? definition['displayThumbColor']: false,
      colorPickerWidth: definition.containsKey('colorPickerWidth') ?  definition['colorPickerWidth']: 300.0,
      pickerAreaHeightPercent: definition.containsKey('pickerAreaHeightPercent') ?  definition['pickerAreaHeightPercent']: 1.0,
    );
  }
}
