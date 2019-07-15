import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteDownButton extends HookWidget {
  final String id;
  final bool isDense;
  final bool isExpanded;
  final int elevation;
  final double iconSize;
  final Widget underline;
  final Widget disabledHint;
  final Widget icon;
  final Widget hint;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final items;
  final value;

  RemoteDownButton(
      {Key key,
      this.id,
      this.elevation,
      this.isDense,
      this.items,
      this.value,
      this.iconSize,
      this.isExpanded,
      this.underline,
      this.disabledHint,
      this.icon,
      this.hint,
      this.iconDisabledColor,
      this.iconEnabledColor})
      : assert(items is List || items is Map, 'items should be a List or a Map not $items'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedValue = useState<dynamic>(value);

    useEffect(() {
      selectedValue.value = value;
      return null;
    }, [value]);

    final dropItems = <DropdownMenuItem>[];
    if (items is List) {
      dropItems.addAll(
        items
            .map((item) => DropdownMenuItem(
                  child: Text(item.toString()),
                  value: item,
                ))
            .toList(growable: false),
      );
    } else if (items is Map) {
      (items as Map).forEach((key, value) => dropItems.add(DropdownMenuItem(
            child: Text(value.toString()),
            value: key,
          )));
    }

    return DropdownButton(
      onChanged: (selected) {
        selectedValue.value = selected;
        RemoteManagerWidget.of(context).onChanges(id, selected, associatedData: RemoteWidgetData.of(context).data);
      },
      items: dropItems,
      elevation: elevation,
      isDense: isDense,
      underline: underline,
      isExpanded: isExpanded,
      iconSize: iconSize,
      icon: icon,
      value: selectedValue.value,
      disabledHint: disabledHint,
      hint: hint,
      iconDisabledColor: iconDisabledColor,
      iconEnabledColor: iconEnabledColor,
    );
  }
}
