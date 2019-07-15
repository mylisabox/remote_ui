import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteCheckbox extends HookWidget {
  final String id;
  final bool value;
  final bool tristate;
  final Color checkColor;
  final Color activeColor;

  const RemoteCheckbox({
    Key key,
    this.id,
    this.value,
    this.tristate,
    this.checkColor,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checked = useState<bool>(value);
    useEffect(() {
      checked.value = value;
      return null;
    }, [value]);

    return Checkbox(
      onChanged: (selected) {
        checked.value = selected;
        RemoteManagerWidget.of(context).onChanges(id, selected, associatedData: RemoteWidgetData.of(context).data);
      },
      value: value,
      activeColor: activeColor,
      checkColor: checkColor,
      tristate: tristate,
    );
  }
}
