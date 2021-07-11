import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteTextField extends HookWidget {
  final String id;
  final String? validator;
  final bool required;
  final String? validatorErrorMessage;
  final bool obscureText;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final bool expands;
  final bool enabled;
  final bool enableInteractiveSelection;
  final bool maxLengthEnforced;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Color? cursorColor;
  final TextDirection? textDirection;
  final Radius? cursorRadius;
  final double cursorWidth;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final InputDecoration decoration;
  final Brightness? keyboardAppearance;
  final String text;

  const RemoteTextField({
    Key? key,
    required this.id,
    this.validator,
    required this.required,
    this.validatorErrorMessage,
    this.maxLengthEnforcement,
    required this.obscureText,
    required this.textAlign,
    required this.autofocus,
    required this.autocorrect,
    required this.expands,
    required this.enabled,
    required this.enableInteractiveSelection,
    required this.maxLengthEnforced,
    required this.textCapitalization,
    this.keyboardType,
    required this.textInputAction,
    this.cursorColor,
    this.textDirection,
    this.cursorRadius,
    required this.cursorWidth,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.keyboardAppearance,
    required this.decoration,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => TextEditingController(text: text), [text]);
    useEffect(() => controller.dispose, [controller]);
    final error = useState<String?>(null);

    return TextField(
      controller: controller,
      onChanged: (text) {
        RemoteManagerWidget.of(context)?.onChanges(id, text, associatedData: RemoteWidgetData.of(context)?.data);
        error.value = null;
        if (validator != null && !RegExp(validator!).hasMatch(text)) {
          error.value = validatorErrorMessage ?? 'Field incorrect, should respect $validator';
        }
      },
      onSubmitted: (text) {
        RemoteManagerWidget.of(context)?.onChanges(id, text, associatedData: RemoteWidgetData.of(context)?.data);
        error.value = null;
        if (validator == null || RegExp(validator!).hasMatch(text)) {
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
      // ignore: deprecated_member_use
      maxLengthEnforced: maxLengthEnforced,
      maxLengthEnforcement: maxLengthEnforcement,
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
