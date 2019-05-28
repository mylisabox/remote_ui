import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class PaddingParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return Padding(
      padding: EdgeInsets.fromLTRB(definition['left'] ?? .0, definition['top'] ?? .0, definition['right'] ?? .0, definition['bottom'] ?? .0),
      child: factory.fromJson(context, definition['child']),
    );
  }
}
