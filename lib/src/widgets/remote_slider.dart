import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteSlider extends HookWidget {
  final double initialValue;
  final String id;
  final Color inactiveColor;
  final Color activeColor;
  final double min;
  final double max;
  final int divisions;
  final String label;

  RemoteSlider({
    this.inactiveColor,
    this.activeColor,
    this.min,
    this.max,
    this.divisions,
    this.label,
    this.initialValue,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final valueState = useState(initialValue);

    return Slider(
      value: valueState.value,
      onChanged: (value) {
        valueState.value = value;
        return RemoteManagerWidget.of(context).onChanges(id, value);
      },
      inactiveColor: inactiveColor,
      activeColor: activeColor,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
    );
  }
}
