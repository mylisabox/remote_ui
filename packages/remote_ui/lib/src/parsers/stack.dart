import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class StackParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return Stack(
      children: List.from(definition['children'].map((item) => factory.fromJson(context, item))),
      textDirection: definition.containsKey('textDirection') ? TextDirection.values[definition['textDirection']] : null,
      overflow: definition.containsKey('overflow') ? Overflow.values[definition['overflow']] : null,
      fit: definition.containsKey('textBaseline') ? StackFit.values[definition['fit']] : null,
    );
  }
}
