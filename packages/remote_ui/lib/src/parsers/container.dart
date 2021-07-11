import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';

class ContainerParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return Container(
      height: factory.getData(definition, data, 'height'),
      width: factory.getData(definition, data, 'width'),
      padding: factory.getEdgeInsets(definition['padding']),
      margin: factory.getEdgeInsets(definition['margin']),
      child: factory.fromJson(context, definition['child'] ?? {}, data),
      color: definition.containsKey('color') ? Color(factory.getData(definition, data, 'color')) : null,
    );
  }
}
