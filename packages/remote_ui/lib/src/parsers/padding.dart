import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';

class PaddingParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return Padding(
      padding: factory.getEdgeInsets(definition['padding'])!,
      child: factory.fromJson(context, definition['child'], data),
    );
  }
}
