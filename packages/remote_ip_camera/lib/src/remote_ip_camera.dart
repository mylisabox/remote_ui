import 'package:flutter/material.dart';
import 'package:remote_ip_camera/src/parsers/ip_camera.dart';
import 'package:remote_ui/remote_ui.dart';

class RemoteIpCameraFactory implements RemoteFactory {
  final IpCameraParser _cameraParser;

  RemoteIpCameraFactory({String Function() baseUrlProvider})
      : _cameraParser = IpCameraParser(baseUrlProvider);

  Widget fromJson(BuildContext context, Map<String, dynamic> definition,
      Map<String, dynamic> data, RemoteWidgetFactory factory) {
    switch (definition['type']) {
      case 'camera':
        return _cameraParser.parse(context, definition, data, factory);
    }
    return null;
  }
}
