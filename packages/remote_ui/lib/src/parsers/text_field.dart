import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';
import 'package:remote_ui/src/widgets/remote_text_field.dart';

class TextFieldParser extends WidgetParser with ColorHexParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return RemoteTextField(
      id: definition['id'],
      validator: definition['validator'],
      required: definition['required'] ?? false,
      validatorErrorMessage: definition['validatorErrorMessage'],
      obscureText: definition['obscureText'] ?? false,
      textAlign: definition.containsKey('textAlign') ? TextAlign.values[definition['textAlign']] : TextAlign.start,
      autofocus: definition['autofocus'] ?? false,
      autocorrect: definition['autocorrect'] ?? true,
      expands: definition['expands'] ?? false,
      enabled: definition['enabled'] ?? true,
      enableInteractiveSelection: definition['enableInteractiveSelection'] ?? true,
      maxLengthEnforced: definition['maxLengthEnforced'] ?? true,
      textCapitalization: definition.containsKey('textCapitalization') ? TextCapitalization.values[definition['textCapitalization']] : TextCapitalization.none,
      keyboardType: definition.containsKey('keyboardType') ? TextInputType.values[definition['keyboardType']] : null,
      textInputAction: definition.containsKey('textInputAction') ? TextInputAction.values[definition['textInputAction']] : TextInputAction.next,
      cursorColor: definition.containsKey('cursorColor') ? Color(parseHex(definition['cursorColor'])) : null,
      textDirection: definition.containsKey('textDirection') ? TextDirection.values[definition['textDirection']] : null,
      cursorRadius: definition.containsKey('cursorRadius') ? Radius.circular(definition['cursorRadius'].toDouble()) : null,
      cursorWidth: definition['cursorWidth']?.toDouble() ?? 2.0,
      maxLength: definition['maxLength'],
      maxLines: definition['maxLines'] ?? 1,
      minLines: definition['minLines'],
      decoration: factory.getInputDecoration(context, definition['decoration'], data),
      keyboardAppearance: definition.containsKey('keyboardAppearance') ? Brightness.values[definition['keyboardAppearance']] : null,
    );
  }
}
