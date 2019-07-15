import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteTextField extends HookWidget {
  final String id;
  final String validator;
  final bool required;
  final String validatorErrorMessage;
  final bool obscureText;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final bool expands;
  final bool enabled;
  final bool enableInteractiveSelection;
  final bool maxLengthEnforced;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;
  final TextDirection textDirection;
  final Radius cursorRadius;
  final double cursorWidth;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final InputDecoration decoration;
  final Brightness keyboardAppearance;
  final String text;

  const RemoteTextField({
    Key key,
    this.id,
    this.validator,
    this.required,
    this.validatorErrorMessage,
    this.obscureText,
    this.textAlign,
    this.autofocus,
    this.autocorrect,
    this.expands,
    this.enabled,
    this.enableInteractiveSelection,
    this.maxLengthEnforced,
    this.textCapitalization,
    this.keyboardType,
    this.textInputAction,
    this.cursorColor,
    this.textDirection,
    this.cursorRadius,
    this.cursorWidth,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.keyboardAppearance,
    this.decoration,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => TextEditingController(text: text), [text]);
    useEffect(() => controller.dispose, [controller]);
    final error = useState<String>(null);

    return TextField(
      controller: controller,
      onChanged: (text) {
        RemoteManagerWidget.of(context).onChanges(id, text, associatedData: RemoteWidgetData.of(context).data);
        error.value = null;
        if (validator != null && !RegExp(validator).hasMatch(text)) {
          error.value = validatorErrorMessage ?? 'Field incorrect, should respect $validator';
        }
      },
      onSubmitted: (text) {
        RemoteManagerWidget.of(context).onChanges(id, text, associatedData: RemoteWidgetData.of(context).data);
        error.value = null;
        if (validator == null || RegExp(validator).hasMatch(text)) {
          if (textInputAction == TextInputAction.next) {
            FocusScope.of(context).focusInDirection(TraversalDirection.down);
          } else {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        } else {
          error.value = validatorErrorMessage ?? 'Field incorrect, should respect $validator';
        }
      },
      obscureText: obscureText,
      textAlign: textAlign,
      autofocus: autofocus,
      autocorrect: autocorrect,
      expands: expands,
      enabled: enabled,
      enableInteractiveSelection: enableInteractiveSelection,
      maxLengthEnforced: maxLengthEnforced,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      cursorColor: cursorColor,
      textDirection: textDirection,
      cursorRadius: cursorRadius,
      cursorWidth: cursorWidth,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      decoration: decoration.copyWith(errorText: error.value),
      keyboardAppearance: keyboardAppearance,
    );
  }
}
