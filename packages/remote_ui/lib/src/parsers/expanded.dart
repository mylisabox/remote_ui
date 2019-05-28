import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class ExpandedParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return Expanded(
      flex: definition.containsKey('flex') ? Color(definition['flex']) : 1,
      child: factory.fromJson(context, definition['child']),
    );
  }
}
