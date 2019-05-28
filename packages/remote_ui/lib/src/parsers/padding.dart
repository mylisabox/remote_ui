import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class PaddingParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return Padding(
      padding: factory.getEdgeInsets(definition['padding']),
      child: factory.fromJson(context, definition['child']),
    );
  }
}
