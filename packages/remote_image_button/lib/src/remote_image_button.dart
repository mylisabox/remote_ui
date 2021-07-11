import 'package:flutter/material.dart';
import 'package:remote_image_button/src/parsers/image_button.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteImageButtonFactory implements RemoteFactory {
  final ImageButtonParser _imageButtonParser;
  final String Function()? baseUrlProvider;

  RemoteImageButtonFactory({this.baseUrlProvider}) : _imageButtonParser = ImageButtonParser(baseUrlProvider ?? () => '');

  Widget? fromJson(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    switch (definition['type']) {
      case 'image_button':
        return _imageButtonParser.parse(context, definition, data, factory);
    }
    return null;
  }
}
