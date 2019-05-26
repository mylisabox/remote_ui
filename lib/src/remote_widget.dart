import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remote_ui/src/widgets/remote_slider.dart';

class RemoteWidgetFactory {
  Widget fromJson(BuildContext context, Map<String, dynamic> definition) {
    if (definition.containsKey('flex') && definition['type'] != 'expanded' && definition['type'] != 'spacer') {
      final flex = definition['flex'];
      definition.remove('flex');
      return Expanded(
        flex: flex,
        child: fromJson(context, definition),
      );
    }
    switch (definition['type']) {
      case 'column':
        return Column(
          children: List.from(definition['children'].map((item) => fromJson(context, item))),
          crossAxisAlignment: definition.containsKey('crossAxisAlignment') ? CrossAxisAlignment.values[definition['crossAxisAlignment']] : CrossAxisAlignment.center,
          mainAxisAlignment: definition.containsKey('mainAxisAlignment') ? MainAxisAlignment.values[definition['mainAxisAlignment']] : MainAxisAlignment.start,
          mainAxisSize: definition.containsKey('mainAxisSize') ? MainAxisSize.values[definition['mainAxisSize']] : MainAxisSize.max,
          textBaseline: definition.containsKey('textBaseline') ? TextBaseline.values[definition['textBaseline']] : null,
        );
      case 'row':
        return Row(
          children: List.from(definition['children'].map((item) => fromJson(context, item))),
          crossAxisAlignment: definition.containsKey('crossAxisAlignment') ? CrossAxisAlignment.values[definition['crossAxisAlignment']] : CrossAxisAlignment.center,
          mainAxisAlignment: definition.containsKey('mainAxisAlignment') ? MainAxisAlignment.values[definition['mainAxisAlignment']] : MainAxisAlignment.start,
          mainAxisSize: definition.containsKey('mainAxisSize') ? MainAxisSize.values[definition['mainAxisSize']] : MainAxisSize.max,
          textBaseline: definition.containsKey('textBaseline') ? TextBaseline.values[definition['textBaseline']] : null,
        );
      case 'stack':
        return Stack(
          children: List.from(definition['children'].map((item) => fromJson(context, item))),
          textDirection: definition.containsKey('textDirection') ? TextDirection.values[definition['textDirection']] : null,
          overflow: definition.containsKey('overflow') ? Overflow.values[definition['overflow']] : null,
          fit: definition.containsKey('textBaseline') ? StackFit.values[definition['fit']] : null,
        );
      case 'expanded':
        return Expanded(
          flex: definition.containsKey('flex') ? Color(definition['flex']) : 1,
          child: fromJson(context, definition['child']),
        );
      case 'padding':
        return Padding(
          padding: EdgeInsets.fromLTRB(definition['left'] ?? .0, definition['top'] ?? .0, definition['right'] ?? .0, definition['bottom'] ?? .0),
          child: definition.containsKey('child') ? fromJson(context, definition['child']) : null,
        );
      case 'container':
        return Container(
          height: definition['height'],
          width: definition['width'],
          child: definition.containsKey('child') ? fromJson(context, definition['child']) : null,
          color: definition.containsKey('color') ? Color(definition['color']) : null,
        );
      case 'slider':
        return RemoteSlider(
          initialValue: definition['value'],
          inactiveColor: definition.containsKey('inactiveColor') ? definition['inactiveColor'] : null,
          activeColor: definition.containsKey('activeColor') ? definition['activeColor'] : null,
          min: definition.containsKey('min') ? definition['min'] : .0,
          max: definition.containsKey('max') ? definition['max'] : 1.0,
          divisions: definition.containsKey('divisions') ? definition['divisions'] : null,
          label: definition.containsKey('label') ? definition['label'] : null,
        );
      case 'text':
        return Text(definition['text']);
      case 'spacer':
        return Spacer(flex: definition['flex']);
      case 'flat_button':
        //TODO
        return FlatButton(
          onPressed: () {},
          child: null,
        );
      case 'raised_button':
        //TODO
        return RaisedButton(
          onPressed: () {},
          child: null,
        );
      case 'color_picker':
        //TODO
        return Placeholder();
    }
    return Placeholder();
  }
}

class RemoteWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const RemoteWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final factory = RemoteWidgetFactory();
    return factory.fromJson(context, data);
  }
}

class RemoteManagerWidget extends InheritedWidget {
  final Function(String key, dynamic value) onChanges;

  RemoteManagerWidget({Key key, this.onChanges, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }

  static RemoteManagerWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(RemoteManagerWidget) as RemoteManagerWidget;
  }
}
