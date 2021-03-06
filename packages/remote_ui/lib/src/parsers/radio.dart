import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';
import 'package:remote_ui/src/widgets/remote_radio.dart';

class RadioParser extends WidgetParser with ColorHexParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return RemoteRadio(
      id: definition['id'],
      value: definition['value'] ?? false,
      groupValue: definition['groupValue'],
      activeColor: definition.containsKey('activeColor') ? Color(parseHex(definition['activeColor'])) : null,
    );
  }
}
