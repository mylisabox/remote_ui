import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';

class RowParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return Row(
      children: List.from(definition['children'].map((item) => factory.fromJson(context, item, data))),
      crossAxisAlignment:
          definition.containsKey('crossAxisAlignment') ? CrossAxisAlignment.values[definition['crossAxisAlignment']] : CrossAxisAlignment.center,
      mainAxisAlignment: definition.containsKey('mainAxisAlignment') ? MainAxisAlignment.values[definition['mainAxisAlignment']] : MainAxisAlignment.start,
      mainAxisSize: definition.containsKey('mainAxisSize') ? MainAxisSize.values[definition['mainAxisSize']] : MainAxisSize.max,
      textBaseline: definition.containsKey('textBaseline') ? TextBaseline.values[definition['textBaseline']] : null,
    );
  }
}
