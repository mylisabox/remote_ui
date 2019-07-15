import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

abstract class _FormValidator {
  bool isValid(dynamic value);
}

class _RegExpFormValidator implements _FormValidator {
  final RegExp regExp;
  final bool allowEmpty;

  _RegExpFormValidator(String regExp, {this.allowEmpty = true}) : this.regExp = RegExp(regExp);

  @override
  bool isValid(value) {
    if (allowEmpty && (value == null || value.toString().isEmpty)) {
      return true;
    }
    return regExp.hasMatch(value.toString());
  }
}

class _IsRequiredFormValidator implements _FormValidator {
  _IsRequiredFormValidator();

  @override
  bool isValid(value) {
    if (value is String) {
      return value != null && value.trim().isNotEmpty;
    } else if (value is bool) {
      return value;
    }
    return value != null;
  }
}

class RemoteFormFactory implements RemoteFactory {
  RemoteFormFactory();

  Widget fromJson(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    final formValidator = RemoteFormValidator.of(context);

    if (definition['id'] == 'submit') {
      definition['enabled'] = formValidator.isFormValid();
    }

    return null;
  }
}

class RemoteFormValidator extends InheritedWidget {
  final Map<String, _FormValidator> validators;
  final Map<String, dynamic> formData;
  RemoteFormValidator({Widget child, this.formData, this.validators = const {}}) : super(child: child);

  bool isFormValid() {
    for (int i = 0; i < validators.entries.length; i++) {
      final validator = validators.entries.elementAt(i);
      if (!validator.value.isValid(formData[validator.key])) {
        return false;
      }
    }

    return true;
  }

  @override
  bool updateShouldNotify(RemoteFormValidator oldWidget) {
    return validators != oldWidget.validators;
  }

  static RemoteFormValidator of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(RemoteFormValidator) as RemoteFormValidator;
  }
}

class RemoteForm extends HookWidget {
  final Map<String, dynamic> definition;
  final Map<String, dynamic> data;
  final dynamic associatedData;
  final List<RemoteFactory> parsers;
  final RemoteWidgetInteraction onChanges;
  final Function(Map<String, dynamic> formData, {dynamic associatedData}) onSubmit;

  const RemoteForm({Key key, @required this.definition, this.data, this.associatedData, @required this.onSubmit, this.parsers = const [], this.onChanges})
      : super(key: key);

  Map<String, _FormValidator> _findValidators(Map<String, dynamic> definition) {
    if (definition == null) {
      return <String, _FormValidator>{};
    }
    final Map<String, _FormValidator> validators = {};

    if (definition['validator'] != null) {
      validators[definition['id']] = _RegExpFormValidator(definition['validator'], allowEmpty: !(definition['required'] ?? false));
    } else if (definition['required'] == true) {
      validators[definition['id']] = _IsRequiredFormValidator();
    }

    validators.addAll(_findValidators(definition['child']));
    if (definition['children'] != null) {
      definition['children'].forEach((child) => validators.addAll(_findValidators(child)));
    }

    return validators;
  }

  @override
  Widget build(BuildContext context) {
    final formData = useState(data ?? <String, dynamic>{});
    final formValidators = useMemoized(() => _findValidators(definition), [definition]);
    return RemoteFormValidator(
      formData: formData.value,
      validators: formValidators,
      child: RemoteManagerWidget(
        child: RemoteWidget(
          definition: definition,
          data: formData.value,
          associatedData: associatedData,
        ),
        parsers: [RemoteFormFactory(), ...parsers],
        onChanges: (key, value, {associatedData}) {
          formData.value = Map.from(formData.value)..[key] = value;

          if (onChanges != null) {
            onChanges(key, value, associatedData: associatedData);
          }
          if (key == 'submit') {
            onSubmit(formData.value, associatedData: associatedData);
          }
        },
      ),
    );
  }
}
