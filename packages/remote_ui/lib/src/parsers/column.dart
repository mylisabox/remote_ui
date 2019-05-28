import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class ColumnParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return Column(
      children: List.from(definition['children'].map((item) => factory.fromJson(context, item))),
      crossAxisAlignment: definition.containsKey('crossAxisAlignment') ? CrossAxisAlignment.values[definition['crossAxisAlignment']] : CrossAxisAlignment.center,
      mainAxisAlignment: definition.containsKey('mainAxisAlignment') ? MainAxisAlignment.values[definition['mainAxisAlignment']] : MainAxisAlignment.start,
      mainAxisSize: definition.containsKey('mainAxisSize') ? MainAxisSize.values[definition['mainAxisSize']] : MainAxisSize.max,
      textBaseline: definition.containsKey('textBaseline') ? TextBaseline.values[definition['textBaseline']] : null,
    );
  }
}
