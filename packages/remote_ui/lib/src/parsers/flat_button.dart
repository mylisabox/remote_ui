import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';

class FlatButtonParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return FlatButton(
      onPressed: definition['enabled'] ?? true
          ? () {
              RemoteManagerWidget.of(context).onChanges(factory.getData(definition, data, 'id'), factory.getData(definition, data, 'value'),
                  associatedData: RemoteWidgetData.of(context).data);
            }
          : null,
      color: definition.containsKey('color') ? Color(factory.getData(definition, data, 'color')) : null,
      disabledTextColor: definition.containsKey('disabledTextColor') ? Color(factory.getData(definition, data, 'disabledTextColor')) : null,
      highlightColor: definition.containsKey('highlightColor') ? Color(factory.getData(definition, data, 'highlightColor')) : null,
      focusColor: definition.containsKey('focusColor') ? Color(factory.getData(definition, data, 'focusColor')) : null,
      hoverColor: definition.containsKey('hoverColor') ? Color(factory.getData(definition, data, 'hoverColor')) : null,
      splashColor: definition.containsKey('splashColor') ? Color(factory.getData(definition, data, 'splashColor')) : null,
      disabledColor: definition.containsKey('disabledColor') ? Color(factory.getData(definition, data, 'disabledColor')) : null,
      textColor: definition.containsKey('textColor') ? Color(factory.getData(definition, data, 'textColor')) : null,
      colorBrightness: definition.containsKey('colorBrightness') ? Brightness.values[definition['colorBrightness']] : null,
      padding: factory.getEdgeInsets(definition['padding']),
      child: factory.fromJson(context, definition['child'], data) ??
          Text(
            factory.getData(definition, data, 'text', defaultValue: '').toString(),
            textAlign: TextAlign.center,
          ),
    );
  }
}
