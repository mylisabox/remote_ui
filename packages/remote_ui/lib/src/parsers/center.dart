import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class CenterParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    return Center(
      child: factory.fromJson(context, definition['child']),
      heightFactor: definition['heightFactor'],
      widthFactor: definition['widthFactor'],
    );
  }
}
