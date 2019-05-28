import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/widgets/remote_slider.dart';

class SliderParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return RemoteSlider(
      initialValue: definition['value'],
      id: definition['id'],
      inactiveColor: definition.containsKey('inactiveColor') ? Color(definition['inactiveColor']) : null,
      activeColor: definition.containsKey('activeColor') ? Color(definition['activeColor']) : null,
      min: definition['min'] ?? .0,
      max: definition['max'] ?? 1.0,
      divisions: definition['divisions'],
      label: definition['label'],
    );
  }
}
