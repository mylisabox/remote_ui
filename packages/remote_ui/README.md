# remote_ui

Flutter widget to manage UI from a JSON definition

## How it works

So all you need is to have a JSON definition of a widget tree, then parse it and give it to `RemoteWidget`, it will take care of creating all your tree.

Example of a JSON widget tree representation: 
```
{
  "type": "column",
  "children": [
    {
      "type": "row",
      "flex": 3,
      "children": [
        {
          "type": "spacer",
          "flex": 1
        },
        {
          "type": "image_button",
          "id": "onoff",
          "flex": 2,
          "mainIndicator": true,
          "values": { "on": "http://test/on.png", "off": "http://test/off.png"},
          "value": "on"
        },
        {
          "type": "spacer",
          "flex": 1
        }
      ]
    },
    {
      "type": "slider",
      "id": "dim",
      "flex": 1,
      "min": 0,
      "divisions": 100,
      "max": 100,
      "value": 50
    }
  ]
}
```

Some widget fields are enums, for those just set them to the integer index of that enum and they'll be used correctly.
 
## Usage

Once you have you're parse JSON data it's really easy, just do:

```
RemoteWidget(
    definition: parsedJsonData,
),
```

### Dynamic data

Might be useful to bind data in case our tree contains form fields, no problem. 

All you need is to modify a bit your JSON and wrap dynamic data between `$` like `$varName$`.

Then you can pass this data to `RemoteWidget`:

```
RemoteWidget(
    definition: parsedJsonData,
    data: {"varName": "myValue"},
),
```

### Interactivity 

If you have buttons or form field, you probably want to get the events back somehow ^^

You can do this with the `RemoteManagerWidget`, his job is to forward all the changes of your interactive widget under him.

Interactive widget need an `id` field to be able to recognize them. Once the user click on the button or slide the slider you'll get the changes under `onChanges` callback

Example: 
```
RemoteManagerWidget(
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
```

## Widget compatibility

Here is the list of currently supported flutter widget:

- Center
- Padding
- Row
- Column
- Stack
- Expended
- FlatButton (partially)
- RaisedButton (partially)
- Slider
- Container
- Spacer
- Text (partially)

## Addons 

### Existing addons

- image_button : Button based on remote images
- color_picker : Color picker widget, inline or with button

### Use an addons

To use an addons all you need to do is to pass the factory to the RemoteManagerWidget.

Example:
```
RemoteManagerWidget(
    parsers: [RemoteImageButtonFactory()],
    child: RemoteWidget(...)
)
```

### Create an addons

I suggest you take a look at the existing addons on how to make a new one. 


