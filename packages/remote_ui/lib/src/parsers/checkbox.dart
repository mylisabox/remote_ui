import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';
import 'package:remote_ui/src/widgets/remote_checkbox.dart';

class CheckboxParser extends WidgetParser with ColorHexParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return RemoteCheckbox(
      id: definition['id'],
      value: definition['value'],
      tristate: definition['tristate'] ?? false,
      checkColor: definition.containsKey('checkColor') ? Color(parseHex(definition['checkColor'])) : null,
      activeColor: definition.containsKey('activeColor') ? Color(parseHex(definition['activeColor'])) : null,
    );
  }
}
