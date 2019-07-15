import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteRadio extends HookWidget {
  final String id;
  final bool value;
  final groupValue;
  final Color activeColor;

  const RemoteRadio({
    Key key,
    this.id,
    this.value,
    this.activeColor,
    this.groupValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checked = useState<bool>(value);
    useEffect(() {
      checked.value = value;
      return null;
    }, [value]);

    return Radio(
      onChanged: (selected) {
        checked.value = selected;
        RemoteManagerWidget.of(context).onChanges(id, selected, associatedData: RemoteWidgetData.of(context).data);
      },
      value: value,
      activeColor: activeColor,
      groupValue: groupValue,
    );
  }
}
