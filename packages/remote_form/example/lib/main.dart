import 'package:flutter/material.dart';
import 'package:remote_form/remote_form.dart';

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
              child: RemoteForm(
                onSubmit: (values, {associatedData}) {
                  debugPrint('form submitted $values');
                },
                associatedData: {},
                onChanges: (key, value, {associatedData}) => debugPrint('$key change to $value'),
                definition: {
                  'type': 'column',
                  'padding': 16,
                  'crossAxisAlignment': CrossAxisAlignment.stretch.index,
                  'children': [
                    {
                      'type': 'dropdown_button',
                      'id': 'gender',
                      'hint': {
                        'type': 'text',
                        'text': 'Gender',
                      },
                      'isExpanded': true,
                      'items': {0: 'Male', 1: 'Female', 2: 'None'}
                    },
                    {
                      'type': 'text_field',
                      'id': 'name',
                      'required': true,
                      'textInputAction': TextInputAction.next.index,
                      'decoration': {
                        'labelText': 'Name*',
                      }
                    },
                    {
                      'type': 'text_field',
                      'id': 'firstname',
                      'textInputAction': TextInputAction.next.index,
                      'decoration': {
                        'labelText': 'First name',
                      }
                    },
                    {
                      'type': 'text_field',
                      'id': 'phone',
                      'keyboardType': TextInputType.phone.index,
                      'textInputAction': TextInputAction.next.index,
                      'validator': '^[0-9+]{8,10}\$',
                      'decoration': {
                        'labelText': 'Phone',
                      }
                    },
                    {
                      'type': 'text_field',
                      'id': 'email',
                      'keyboardType': TextInputType.emailAddress.index,
                      'textInputAction': TextInputAction.done.index,
                      'validator': '[a-zA-Z0-9]+@[a-zA-Z0-9]+\\.[a-zA-Z]+',
                      'validatorErrorMessage': 'Email invalid',
                      'decoration': {
                        'labelText': 'Email',
                      }
                    },
                    {
                      'type': 'raised_button',
                      'id': 'submit',
                      'child': {
                        'type': 'text',
                        'text': 'Submit',
                      }
                    }
                  ],
                },
                data: {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
