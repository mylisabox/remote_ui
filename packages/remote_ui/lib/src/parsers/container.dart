import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class ContainerParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return Container(
      height: definition['height'],
      width: definition['width'],
      padding: factory.getEdgeInsets(definition['padding']),
      margin: factory.getEdgeInsets(definition['margin']),
      child: factory.fromJson(context, definition['child']),
      color: definition.containsKey('color') ? Color(definition['color']) : null,
    );
  }
}
