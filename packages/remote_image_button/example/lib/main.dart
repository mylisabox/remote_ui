import 'package:flutter/material.dart';
import 'package:remote_image_button/remote_image_button.dart';
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
                parsers: [RemoteImageButtonFactory()],
                onChanges: (key, value, {associatedData}) => debugPrint('$key change to $value'),
                child: RemoteWidget(
                  definition: {
                    'type': 'column',
                    'children': [
                      {
                        'type': 'image_button',
                        'id': 'myButton',
                        'value': 'on',
                        'values': {
                          'on': 'https://www.iconexperience.com/_img/v_collection_png/256x256/shadow/lightbulb_on.png',
                          'off': 'https://www.iconexperience.com/_img/v_collection_png/256x256/shadow/lightbulb.png',
                        }
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
