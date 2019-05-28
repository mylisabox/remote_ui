import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';

class CenterParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return Center(
      child: factory.fromJson(context, definition['child'], data),
      heightFactor: definition['heightFactor'],
      widthFactor: definition['widthFactor'],
    );
  }
}
