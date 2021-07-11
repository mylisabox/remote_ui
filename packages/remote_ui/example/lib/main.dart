import 'package:flutter/material.dart';
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
                onChanges: (key, value, {associatedData}) => debugPrint('$key change to $value'),
                child: RemoteWidget(
                  data: {
                    'myColor': 0xFFFF00FF,
                    'sliderData': {
                      'sliderValue': .2,
                    }
                  },
                  definition: {
                    'type': 'column',
                    'crossAxisAlignment': CrossAxisAlignment.stretch.index,
                    'children': [
                      {
                        'type': 'row',
                        'flex': 1,
                        'crossAxisAlignment': CrossAxisAlignment.stretch.index,
                        'children': [
                          {
                            'type': 'container',
                            'color': '\$myColor\$',
                            'width': 80.0,
                          },
                          {
                            'type': 'expanded',
                            'child': {
                              'type': 'container',
                              'color': 0xFF00FFFF,
                            }
                          },
                          {
                            'type': 'container',
                            'color': 0xFFFFFF00,
                            'width': 80.0,
                          },
                        ]
                      },
                      {'type': 'slider', 'id': 'brightness', 'value': '\$sliderData.sliderValue\$'}
                    ],
                  },
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
