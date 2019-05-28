import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';

class StackParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return Stack(
      children: List.from(definition['children'].map((item) => factory.fromJson(context, item, data))),
      textDirection: definition.containsKey('textDirection') ? TextDirection.values[definition['textDirection']] : null,
      overflow: definition.containsKey('overflow') ? Overflow.values[definition['overflow']] : null,
      fit: definition.containsKey('textBaseline') ? StackFit.values[definition['fit']] : null,
    );
  }
}
