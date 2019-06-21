import 'package:flutter/material.dart';
import 'package:remote_ip_camera/src/widgets/ip_camera.dart';
import 'package:remote_ui/remote_ui.dart';

class IpCameraParser extends WidgetParser with ColorHexParser {
  IpCameraParser();

  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    final color = factory.getData(definition, data, 'color');
    return IpCamera(
      id: factory.getData(definition, data, 'id'),
      stream: factory.getData(definition, data, 'stream'),
      color: definition.containsKey('color') ? Color(parseHex(color)) : null,
      preview: factory.getData(definition, data, 'preview'),
      width: factory.getData(definition, data, 'width')?.toDouble(),
      height: factory.getData(definition, data, 'height')?.toDouble(),
      fit: definition.containsKey('fit') ? BoxFit.values[factory.getData(definition, data, 'fit')] : BoxFit.cover,
    );
  }
}
