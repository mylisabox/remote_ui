# remote_color_picker

Flutter widget to manage Color picker UI from a JSON definition

This is a [Remote UI plugin][remote_ui].

## Usage

Add the factory to the RemoteManagerWidget:

```
RemoteManagerWidget(
    parsers: [RemoteColorPickerFactory()],
    child: RemoteWidget(...)
)
``` 

Then you can provide a JSON representation of a color picker like this:

```
{
    'type': 'color_picker',
    'id': 'myColor',
    'value': 0XFFFF0000,
},
```

or inline:
```
{
    'type': 'color_picker_inline',
    'id': 'myColor',
    'value': 0XFFFF0000,
},
```

## API
Color picker:

`id` : id of the widget
`buttonWidth` : width of the color button, default 35, only if not inline
`buttonHeight`: height of the color button, default 35, only if not inline
`value` : hex integer or string representation of a color
`enableAlpha`: enable alpha slider, default true
`enableLabel`: enable label, default true
`colorPickerWidth`: color picker width, default to 300
`pickerAreaHeightPercent`: picker are height in percent, default 1, double between 0-1
`displayThumbColor`: display thumb color, default to false
`paletteType`: palette type, default to hsv (0), hsv:0, hsl:1
`paletteType`: palette type, default to hsv (0), hsv:0, hsl:1

[remote_ui]: https://github.com/jaumard/remote_ui/tree/master/packages/remote_ui
