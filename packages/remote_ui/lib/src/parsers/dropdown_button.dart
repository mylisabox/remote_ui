import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';
import 'package:remote_ui/src/widgets/remote_dropdown_button.dart';

class DropdownButtonParser extends WidgetParser with ColorHexParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return RemoteDropdownButton(
      id: definition['id'],
      elevation: definition['elevation'] ?? 8,
      isDense: definition['isDense'] ?? false,
      items: factory.getData(definition, data, 'items', defaultValue: []),
      value: factory.getData(definition, data, 'value'),
      values: factory.getData(definition, data, 'values', defaultValue: []),
      iconSize: definition['iconSize'] ?? 24.0,
      isExpanded: definition['isExpanded'] ?? false,
      underline: factory.fromJson(context, definition['underline'], data),
      disabledHint: factory.fromJson(context, definition['disabledHint'], data),
      icon: factory.fromJson(context, definition['icon'], data),
      hint: factory.fromJson(context, definition['hint'], data),
      iconDisabledColor: definition.containsKey('iconDisabledColor') ? Color(parseHex(definition['iconDisabledColor'])) : null,
      iconEnabledColor: definition.containsKey('iconEnabledColor') ? Color(parseHex(definition['iconEnabledColor'])) : null,
    );
  }
}
