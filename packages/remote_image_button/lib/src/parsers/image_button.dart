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
      id: definition['id'],
    );
  }
}
