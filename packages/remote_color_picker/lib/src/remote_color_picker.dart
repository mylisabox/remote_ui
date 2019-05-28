import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remote_color_picker/src/parsers/color_picker.dart';
import 'package:remote_color_picker/src/parsers/color_picker_inline.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteColorPickerFactory implements RemoteFactory {
  final ColorPickerParser _colorPickerParser = ColorPickerParser();
  final ColorPickerInlineParser _colorPickerInlineParser = ColorPickerInlineParser();

  Widget fromJson(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {

    switch (definition['type']) {
      case 'color_picker':
        return _colorPickerParser.parse(context, definition, factory);
      case 'color_picker_inline':
        return _colorPickerInlineParser.parse(context, definition, factory);
    }
    return null;
  }
}
