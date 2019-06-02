import 'package:flutter/material.dart';
import 'package:remote_image_button/src/widgets/image_button.dart';
import 'package:remote_ui/remote_ui.dart';

class ImageButtonParser extends WidgetParser {
  final String Function() baseUrlProvider;

  ImageButtonParser(this.baseUrlProvider);

  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    return ImageButton(
      baseUrlProvider: baseUrlProvider,
      value: factory.getData(definition, data, 'value'),
      values: factory.getData(definition, data, 'values'),
      width: factory.getData(definition, data, 'width')?.toDouble(),
      height: factory.getData(definition, data, 'height')?.toDouble(),
      fit: definition.containsKey('fit') ? BoxFit.values[factory.getData(definition, data, 'fit')] : BoxFit.contain,
      id: definition['id'],
      padding: factory.getEdgeInsets(definition['padding']) ?? EdgeInsets.zero,
    );
  }
}
