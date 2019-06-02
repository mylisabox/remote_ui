import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as picker;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_color_picker/src/utils/mixin.dart';
import 'package:remote_ui/remote_ui.dart';

class ColorPickerInline extends HookWidget with ColorToHex {
  final Color value;
  final String id;
  final double colorPickerWidth;
  final bool displayThumbColor;
  final bool enableAlpha;
  final bool enableLabel;
  final double pickerAreaHeightPercent;
  final picker.PaletteType paletteType;
  final bool isOutputHexString;
  final bool includeAlphaInHexString;

  ColorPickerInline({
    this.isOutputHexString = false,
    this.includeAlphaInHexString = true,
    this.paletteType,
    this.displayThumbColor,
    this.enableAlpha,
    this.enableLabel,
    this.pickerAreaHeightPercent,
    this.colorPickerWidth,
    this.value,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final valueState = useState(value);
    useEffect(() {
      valueState.value = value;
    }, [value]);
    return picker.ColorPicker(
      pickerColor: valueState.value,
      onColorChanged: (color) {
        valueState.value = color;
        RemoteManagerWidget.of(context).onChanges(id, isOutputHexString ? toHex(valueState.value, includeAlphaInHexString) : valueState.value.value,
            associatedData: RemoteWidgetData.of(context).data);
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
