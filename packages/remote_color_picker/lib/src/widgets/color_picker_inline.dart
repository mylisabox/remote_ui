import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as picker;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class ColorPickerInline extends HookWidget {
  final Color initialValue;
  final String id;
  final double colorPickerWidth;
  final bool displayThumbColor;
  final bool enableAlpha;
  final bool enableLabel;
  final double pickerAreaHeightPercent;
  final picker.PaletteType paletteType;

  ColorPickerInline({
    this.paletteType,
    this.displayThumbColor,
    this.enableAlpha,
    this.enableLabel,
    this.pickerAreaHeightPercent,
    this.colorPickerWidth,
    this.initialValue,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final valueState = useState(initialValue);
    return picker.ColorPicker(
      valueState.value,
      (color) {
        valueState.value = color;
        RemoteManagerWidget.of(context).onChanges(id, color);
      },
      colorPickerWidth: colorPickerWidth,
      displayThumbColor: displayThumbColor,
      enableAlpha: enableAlpha,
      enableLabel: enableLabel,
      paletteType: paletteType,
      pickerAreaHeightPercent: pickerAreaHeightPercent,
    );
  }
}
