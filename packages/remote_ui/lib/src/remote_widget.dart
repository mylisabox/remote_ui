import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remote_ui/src/parsers/center.dart';
import 'package:remote_ui/src/parsers/column.dart';
import 'package:remote_ui/src/parsers/container.dart';
import 'package:remote_ui/src/parsers/expanded.dart';
import 'package:remote_ui/src/parsers/flat_button.dart';
import 'package:remote_ui/src/parsers/padding.dart';
import 'package:remote_ui/src/parsers/raised_button.dart';
import 'package:remote_ui/src/parsers/row.dart';
import 'package:remote_ui/src/parsers/slider.dart';
import 'package:remote_ui/src/parsers/spacer.dart';
import 'package:remote_ui/src/parsers/stack.dart';
import 'package:remote_ui/src/parsers/text.dart';

abstract class RemoteFactory {
  Widget fromJson(BuildContext context, Map<String, dynamic> definition, RemoteWidgetFactory factory);
}

class RemoteWidgetFactory {
  final List<RemoteFactory> _customParsers;
  final ColumnParser _columnParser = ColumnParser();
  final RowParser _rowParser = RowParser();
  final StackParser _stackParser = StackParser();
  final PaddingParser _paddingParser = PaddingParser();
  final ExpandedParser _expandedParser = ExpandedParser();
  final ContainerParser _containerParser = ContainerParser();
  final SliderParser _sliderParser = SliderParser();
  final TextParser _textParser = TextParser();
  final FlatButtonParser _flatButtonParser = FlatButtonParser();
  final RaisedButtonParser _raisedButtonParser = RaisedButtonParser();
  final SpacerParser _spacerParser = SpacerParser();
  final CenterParser _centerParser = CenterParser();

  RemoteWidgetFactory(this._customParsers);

  Widget fromJson(BuildContext context, Map<String, dynamic> definition) {
    if (definition == null) {
      return null;
    }

    if (definition.containsKey('flex') && definition['type'] != 'expanded' && definition['type'] != 'spacer') {
      final flex = definition['flex'];
      definition.remove('flex');
      return Expanded(
        flex: flex,
        child: fromJson(context, definition),
      );
    }

    for (var parser in _customParsers) {
      final item = parser.fromJson(context, definition, this);
      if (item != null) {
        return item;
      }
    }

    switch (definition['type']) {
      case 'center':
        return _centerParser.parse(context, definition, this);
      case 'column':
        return _columnParser.parse(context, definition, this);
      case 'row':
        return _rowParser.parse(context, definition, this);
      case 'stack':
        return _stackParser.parse(context, definition, this);
      case 'expanded':
        return _expandedParser.parse(context, definition, this);
      case 'padding':
        return _paddingParser.parse(context, definition, this);
      case 'container':
        return _containerParser.parse(context, definition, this);
      case 'slider':
        return _sliderParser.parse(context, definition, this);
      case 'text':
        return _textParser.parse(context, definition, this);
      case 'spacer':
        return _spacerParser.parse(context, definition, this);
      case 'flat_button':
        return _flatButtonParser.parse(context, definition, this);
      case 'raised_button':
        return _raisedButtonParser.parse(context, definition, this);
    }
    return Placeholder();
  }
}

class RemoteWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const RemoteWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final factory = RemoteWidgetFactory(RemoteManagerWidget.of(context).parsers);
    return factory.fromJson(context, data);
  }
}

class RemoteManagerWidget extends InheritedWidget {
  final Function(String key, dynamic value) onChanges;
  final List<RemoteFactory> parsers;

  RemoteManagerWidget({Key key, this.onChanges, Widget child, this.parsers = const []}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(RemoteManagerWidget oldWidget) {
    return oldWidget.onChanges != onChanges;
  }

  static RemoteManagerWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(RemoteManagerWidget) as RemoteManagerWidget;
  }
}
