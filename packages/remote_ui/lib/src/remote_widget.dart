import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/center.dart';
import 'package:remote_ui/src/parsers/checkbox.dart';
import 'package:remote_ui/src/parsers/column.dart';
import 'package:remote_ui/src/parsers/container.dart';
import 'package:remote_ui/src/parsers/dropdown_button.dart';
import 'package:remote_ui/src/parsers/expanded.dart';
import 'package:remote_ui/src/parsers/flat_button.dart';
import 'package:remote_ui/src/parsers/padding.dart';
import 'package:remote_ui/src/parsers/radio.dart';
import 'package:remote_ui/src/parsers/raised_button.dart';
import 'package:remote_ui/src/parsers/row.dart';
import 'package:remote_ui/src/parsers/slider.dart';
import 'package:remote_ui/src/parsers/spacer.dart';
import 'package:remote_ui/src/parsers/stack.dart';
import 'package:remote_ui/src/parsers/switch.dart';
import 'package:remote_ui/src/parsers/text.dart';
import 'package:remote_ui/src/parsers/text_field.dart';

abstract class RemoteFactory {
  Widget? fromJson(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory);
}

class RemoteWidgetFactory with ColorHexParser {
  final List<RemoteFactory> _customParsers;
  final ColumnParser _columnParser = ColumnParser();
  final RowParser _rowParser = RowParser();
  final StackParser _stackParser = StackParser();
  final PaddingParser _paddingParser = PaddingParser();
  final ExpandedParser _expandedParser = ExpandedParser();
  final ContainerParser _containerParser = ContainerParser();
  final SliderParser _sliderParser;
  final TextParser _textParser = TextParser();
  final FlatButtonParser _flatButtonParser;
  final RaisedButtonParser _raisedButtonParser;
  final SpacerParser _spacerParser = SpacerParser();
  final CenterParser _centerParser = CenterParser();
  final TextFieldParser _textFieldParser = TextFieldParser();
  final DropdownButtonParser _dropdownButtonParser = DropdownButtonParser();
  final CheckboxParser _checkboxParser = CheckboxParser();
  final RadioParser _radioParser = RadioParser();
  final SwitchParser _switchParser = SwitchParser();

  RemoteWidgetFactory(this._customParsers)
      : _raisedButtonParser = RaisedButtonParser(),
        _sliderParser = SliderParser(),
        _flatButtonParser = FlatButtonParser();

  dynamic? getData(Map<String, dynamic> definition, Map<String, dynamic> data, String key, {defaultValue}) {
    var definitionData = definition[key];
    if (definitionData is String && definitionData.startsWith('\$') && definitionData.endsWith('\$')) {
      return _getSubData(data, definitionData, defaultValue: defaultValue);
    }
    if (defaultValue is num && definitionData is String) {
      definitionData = num.tryParse(definitionData);
    }
    return definitionData ?? defaultValue;
  }

  dynamic _getSubData(Map<String, dynamic> data, String dataKey, {defaultValue}) {
    if (data.isEmpty) {
      return defaultValue;
    }

    final parsedKey = dataKey.replaceAll('\$', '');

    if (parsedKey.contains('.')) {
      final parts = parsedKey.split('.');
      return _getSubData(data[parts.first], parts.sublist(1).join('.'));
    }
    var value = data[parsedKey];
    if (defaultValue is num && value is String) {
      value = num.tryParse(value);
    }
    return value ?? defaultValue;
  }

  EdgeInsets? getEdgeInsets(definition) {
    if (definition == null) {
      return null;
    }

    if (definition is Map) {
      return EdgeInsets.fromLTRB(
        definition['left']?.toDouble() ?? .0,
        definition['top']?.toDouble() ?? .0,
        definition['right']?.toDouble() ?? .0,
        definition['bottom']?.toDouble() ?? .0,
      );
    }
    return EdgeInsets.all(definition.toDouble());
  }

  InputDecoration getInputDecoration(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data) {
    if (definition.isEmpty) {
      return InputDecoration();
    }

    return InputDecoration(
      hintMaxLines: definition['hintMaxLines'],
      hintText: definition['hintText'],
      errorText: definition['errorText'],
      alignLabelWithHint: definition['alignLabelWithHint'] ?? false,
      labelText: definition['labelText'],
      counterText: definition['counterText'],
      enabled: definition['enabled'] ?? true,
      errorMaxLines: definition['errorMaxLines'],
      filled: definition['filled'] ?? false,
      fillColor: definition.containsKey('fillColor') ? Color(parseHex(definition['fillColor'])) : null,
      // ignore: deprecated_member_use
      hasFloatingPlaceholder: definition['hasFloatingPlaceholder'] ?? true,
      helperText: definition['helperText'],
      isDense: definition['isDense'] ?? false,
      prefixText: definition['prefixText'],
      semanticCounterText: definition['semanticCounterText'],
      suffixText: definition['suffixText'],
      counter: fromJson(context, definition['counter'], data),
      prefixIcon: fromJson(context, definition['prefixIcon'], data),
      suffixIcon: fromJson(context, definition['suffixIcon'], data),
      icon: fromJson(context, definition['icon'], data),
      prefix: fromJson(context, definition['prefix'], data),
      suffix: fromJson(context, definition['suffix'], data),
    );
  }

  Widget? fromJson(BuildContext context, Map<String, dynamic>? definition, Map<String, dynamic> data) {
    if (definition == null || definition.isEmpty) {
      return null;
    }

    if (definition.containsKey('flex') && definition['type'] != 'expanded' && definition['type'] != 'spacer') {
      final flex = definition['flex'];

      return Expanded(
        flex: flex,
        child: fromJson(context, Map.from(definition)..remove('flex'), data)!,
      );
    }

    if (definition.containsKey('padding') && definition['type'] != 'padding' && definition['type'] != 'container') {
      final padding = definition['padding'];

      return Padding(
        padding: getEdgeInsets(padding)!,
        child: fromJson(context, Map.from(definition)..remove('padding'), data),
      );
    }

    for (var parser in _customParsers) {
      final item = parser.fromJson(context, definition, data, this);
      if (item != null) {
        return item;
      }
    }

    switch (definition['type']) {
      case 'center':
        return _centerParser.parse(context, definition, data, this);
      case 'column':
        return _columnParser.parse(context, definition, data, this);
      case 'row':
        return _rowParser.parse(context, definition, data, this);
      case 'stack':
        return _stackParser.parse(context, definition, data, this);
      case 'expanded':
        return _expandedParser.parse(context, definition, data, this);
      case 'padding':
        return _paddingParser.parse(context, definition, data, this);
      case 'container':
        return _containerParser.parse(context, definition, data, this);
      case 'slider':
        return _sliderParser.parse(context, definition, data, this);
      case 'text':
        return _textParser.parse(context, definition, data, this);
      case 'spacer':
        return _spacerParser.parse(context, definition, data, this);
      case 'flat_button':
        return _flatButtonParser.parse(context, definition, data, this);
      case 'raised_button':
        return _raisedButtonParser.parse(context, definition, data, this);
      case 'text_field':
        return _textFieldParser.parse(context, definition, data, this);
      case 'checkbox':
        return _checkboxParser.parse(context, definition, data, this);
      case 'radio':
        return _radioParser.parse(context, definition, data, this);
      case 'switch':
        return _switchParser.parse(context, definition, data, this);
      case 'dropdown_button':
        return _dropdownButtonParser.parse(context, definition, data, this);
    }
    debugPrint((definition['type'] ?? definition.toString()) + ' is not currently supported by remote_ui');
    return Placeholder();
  }
}

class RemoteWidgetData extends InheritedWidget {
  final data;

  RemoteWidgetData({this.data, required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(RemoteWidgetData oldWidget) {
    return oldWidget.data != data;
  }

  static RemoteWidgetData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RemoteWidgetData>();
  }
}

class RemoteWidget extends StatelessWidget {
  final associatedData;
  final Map<String, dynamic> data;
  final Map<String, dynamic> definition;

  const RemoteWidget({Key? key, required this.definition, this.associatedData, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final factory = RemoteWidgetFactory(RemoteManagerWidget.of(context)?.parsers ?? []);
    return RemoteWidgetData(
      child: Builder(builder: (context) => factory.fromJson(context, definition, data) ?? SizedBox()),
      data: associatedData,
    );
  }
}

typedef RemoteWidgetInteraction = Function(String key, dynamic value, {dynamic associatedData});

class RemoteManagerWidget extends InheritedWidget {
  final RemoteWidgetInteraction onChanges;
  final List<RemoteFactory> parsers;

  RemoteManagerWidget({Key? key, required this.onChanges, required Widget child, this.parsers = const []}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(RemoteManagerWidget oldWidget) {
    return oldWidget.onChanges != onChanges;
  }

  static RemoteManagerWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RemoteManagerWidget>();
  }
}
