import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';

class ExpandedParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return Expanded(
      flex: factory.getData(definition, data, 'flex', defaultValue: 1),
      child: factory.fromJson(context, definition['child'], data)!,
    );
  }
}
