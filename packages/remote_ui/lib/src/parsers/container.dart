import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class ContainerParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return Container(
      height: definition['height'],
      width: definition['width'],

      child: factory.fromJson(context, definition['child']),
      color: definition.containsKey('color') ? Color(definition['color']) : null,
    );
  }
}
