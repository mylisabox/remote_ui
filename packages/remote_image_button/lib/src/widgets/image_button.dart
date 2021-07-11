import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_image_button/src/widgets/image_svg.dart';
import 'package:remote_ui/remote_ui.dart';

class ImageButton extends HookWidget {
  final String Function() baseUrlProvider;
  final value;
  final values;
  final String id;
  final double? width;
  final double? height;
  final BoxFit fit;
  final EdgeInsets padding;

  ImageButton({
    required this.fit,
    this.width,
    this.height,
    required this.baseUrlProvider,
    required this.value,
    required this.values,
    required this.id,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final valueState = useState(value);

    useEffect(() {
      valueState.value = value;
      return null;
    }, [value]);

    final url = prefixWithBaseUrl(values == null ? valueState.value : values[valueState.value]);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (values is Map) {
            final keys = values.keys.toList();
            for (var i = 0; i < keys.length; i++) {
              final key = keys[i];
              if (key == valueState.value) {
                valueState.value = keys.length > i + 1 ? keys[i + 1] : keys[0];
                break;
              }
            }
          } else if (values != null) {
            if (valueState.value + 1 >= values.length) {
              valueState.value = 0;
            } else {
              valueState.value = value + 1;
            }
          }
          RemoteManagerWidget.of(context)?.onChanges(id, valueState.value, associatedData: RemoteWidgetData.of(context)?.data);
        },
        child: Padding(
          child: url.endsWith('.svg')
              ? ImageSvg(
                  url: url,
                  height: height,
                  width: width,
                  fit: fit,
                )
              : Image.network(
                  url,
                  width: width,
                  height: height,
                  fit: fit,
                ),
          padding: padding,
        ),
      ),
    );
  }

  String prefixWithBaseUrl(String value) {
    if (value.startsWith('http')) {
      return value;
    }
    return baseUrlProvider() + value;
  }
}
