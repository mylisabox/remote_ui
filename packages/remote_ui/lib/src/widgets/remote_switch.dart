import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteSwitch extends HookWidget {
  final String id;
  final bool value;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;

  const RemoteSwitch({
    Key? key,
    required this.id,
    required this.value,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checked = useState<bool>(value);
    useEffect(() {
      checked.value = value;
      return null;
    }, [value]);

    return Switch(
      onChanged: (selected) {
        checked.value = selected;
        RemoteManagerWidget.of(context)?.onChanges(id, selected, associatedData: RemoteWidgetData.of(context)?.data);
      },
      value: value,
      activeColor: activeColor,
      activeTrackColor: activeTrackColor,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
    );
  }
}
