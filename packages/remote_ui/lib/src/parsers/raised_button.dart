import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';

class RaisedButtonParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    //TODO
    return RaisedButton(
      onPressed: () {
        RemoteManagerWidget.of(context)
            .onChanges(factory.getData(definition, data, 'id'), factory.getData(definition, data, 'value'), associatedData: RemoteWidgetData.of(context).data);
      },
      child: factory.fromJson(context, definition['child'], data) ??
          Text(
            factory.getData(definition, data, 'text', defaultValue: '').toString(),
            textAlign: TextAlign.center,
          ),
    );
  }
}
