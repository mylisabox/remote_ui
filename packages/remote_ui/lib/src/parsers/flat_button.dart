import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';

class FlatButtonParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory) {
    //TODO
    return FlatButton(
      onPressed: () {
        RemoteManagerWidget.of(context).onChanges(definition['id'], definition['value']);
      },
      child: factory.fromJson(context, definition['child']) ?? Text(definition['text']),
    );
  }
}
