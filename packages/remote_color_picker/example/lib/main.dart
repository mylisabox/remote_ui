import 'package:flutter/material.dart';
import 'package:remote_color_picker/remote_color_picker.dart';
import 'package:remote_ui/remote_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: RemoteManagerWidget(
                parsers: [RemoteColorPickerFactory()],
                onChanges: (key, value, {associatedData}) => debugPrint('$key change to $value'),
                child: RemoteWidget(
                  definition: {
                    'type': 'column',
                    'crossAxisAlignment': CrossAxisAlignment.stretch.index,
                    'children': [
                      {
                        'type': 'container',
                        'child': {'type': 'color_picker_inline', 'id': 'myInlineColor'},
                      },
                      {
                        'type': 'color_picker',
                        'id': 'myColor',
                        'value': 0XFFFF0000,
                        'flex': 1,
                      },
                      {
                        'type': 'slider',
                        'id': 'brightness',
                        'value': 0.4,
                      }
                    ],
                  }, data: {},
                ),
              ),
            ),
            Text(
              'You have pushed the button this many times:',
              textAlign: TextAlign.center,
            ),
            Text(
              '$_counter',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
