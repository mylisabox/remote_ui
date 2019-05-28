import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/widgets/remote_slider.dart';

class SliderParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return RemoteSlider(
      initialValue: definition['value'],
      id: definition['id'],
      inactiveColor: definition.containsKey('inactiveColor') ? definition['inactiveColor'] : null,
      activeColor: definition.containsKey('activeColor') ? definition['activeColor'] : null,
      min: definition.containsKey('min') ? definition['min'] : .0,
      max: definition.containsKey('max') ? definition['max'] : 1.0,
      divisions: definition.containsKey('divisions') ? definition['divisions'] : null,
      label: definition.containsKey('label') ? definition['label'] : null,
    );
  }
}
