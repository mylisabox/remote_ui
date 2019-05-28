import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class TextParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return Text(definition['text']);
  }
}
