import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';
import 'package:remote_ui/src/widgets/remote_slider.dart';

class SliderParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return RemoteSlider(
      value: factory.getData(definition, data, 'value', defaultValue: .0),
      id: definition['id'],
      inactiveColor: definition.containsKey('inactiveColor') ? Color(factory.getData(definition, data, 'inactiveColor')) : null,
      activeColor: definition.containsKey('activeColor') ? Color(factory.getData(definition, data, 'activeColor')) : null,
      min: factory.getData(definition, data, 'min', defaultValue: .0),
      max: factory.getData(definition, data, 'max', defaultValue: 1.0),
      divisions: factory.getData(definition, data, 'divisions'),
      label: factory.getData(definition, data, 'label'),
    );
  }
}
