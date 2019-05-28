
import 'package:flutter/widgets.dart';
import 'package:remote_ui/remote_ui.dart';

abstract class WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory);
}
