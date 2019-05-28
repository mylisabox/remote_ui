import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class SpacerParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return Spacer(flex: definition['flex'] ?? 1);
  }
}
