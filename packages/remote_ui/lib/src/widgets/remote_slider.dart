import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteSlider extends HookWidget {
  final double value;
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
    this.value,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final valueState = useState(value);

    useEffect(() {
      valueState.value = value;
    }, [value]);

    return Slider(
      value: valueState.value,
      onChanged: (value) {
        valueState.value = value;
      },
      onChangeEnd: (value) {
        RemoteManagerWidget.of(context).onChanges(id, value, associatedData: RemoteWidgetData.of(context).data);
      },
      inactiveColor: inactiveColor ?? Theme.of(context).primaryColor.withOpacity(0.24),
      activeColor: activeColor ?? Theme.of(context).primaryColor,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
    );
  }
}
