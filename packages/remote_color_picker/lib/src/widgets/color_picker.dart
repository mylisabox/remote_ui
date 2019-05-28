import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as picker;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class ColorPicker extends HookWidget {
  final Color initialValue;
  final String id;
  final double colorPickerWidth;
  final bool displayThumbColor;
  final bool enableAlpha;
  final bool enableLabel;
  final double pickerAreaHeightPercent;
  final picker.PaletteType paletteType;

  ColorPicker({
    this.initialValue,
    this.id,
    this.paletteType,
    this.displayThumbColor,
    this.enableAlpha,
    this.enableLabel,
    this.pickerAreaHeightPercent,
    this.colorPickerWidth,
  });

  @override
  Widget build(BuildContext context) {
    final valueState = useState(initialValue);

    return Center(
      child: Container(
        color: valueState.value,
        width: 50,
        height: 50,
        child: InkWell(
          onTap: () {
            _showDialog(context, valueState);
          },
          child: Container(),
        ),
      ),
    );
  }

  void _showDialog(BuildContext mainContext, ValueNotifier<Color> valueState) {
    showDialog(
      context: mainContext,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: picker.ColorPicker(
              valueState.value,
              (color) {
                valueState.value = color;
              },
              enableLabel: enableLabel,
              enableAlpha: enableAlpha,
              paletteType: paletteType,
              displayThumbColor: displayThumbColor,
              colorPickerWidth: colorPickerWidth,
              pickerAreaHeightPercent: pickerAreaHeightPercent,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Got it'),
              onPressed: () {
                RemoteManagerWidget.of(mainContext).onChanges(id, valueState.value);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
