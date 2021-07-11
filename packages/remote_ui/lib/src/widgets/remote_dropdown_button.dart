import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteDropdownButton extends HookWidget {
  final String id;
  final bool isDense;
  final bool isExpanded;
  final int elevation;
  final double iconSize;
  final Widget? underline;
  final Widget? disabledHint;
  final Widget? icon;
  final Widget? hint;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final items;
  final values;
  final value;

  RemoteDropdownButton(
      {Key? key,
      required this.id,
      required this.elevation,
      required this.isDense,
      this.items,
      this.value,
      this.values,
      required this.iconSize,
      required this.isExpanded,
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

    final dropItems = <DropdownMenuItem>[];
    var currentValue;
    if (items is List) {
      if (items.contains(value)) {
        currentValue = value;
      }
      dropItems.addAll(
        items
            .map((item) => DropdownMenuItem(
                  child: Text(item.toString()),
                  value: item,
                ))
            .toList(growable: false).cast<DropdownMenuItem>(),
      );
    } else if (items is Map) {
      if ((items as Map).values.contains(value)) {
        currentValue = value;
      }
      (items as Map).forEach((key, value) => dropItems.add(DropdownMenuItem(
            child: Text(value.toString()),
            value: key,
          )));
    }

    useEffect(() {
      selectedValue.value = currentValue;
      return null;
    }, [value]);

    return DropdownButton<dynamic>(
      onChanged: (selected) {
        selectedValue.value = selected;
        RemoteManagerWidget.of(context)?.onChanges(id, selected, associatedData: RemoteWidgetData.of(context)?.data);
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
