# remote_image_button

Flutter widget to manage an image button UI from a JSON definition

This is a [Remote UI plugin][remote_ui].

## Usage

Add the factory to the RemoteManagerWidget:

```
RemoteManagerWidget(
    parsers: [RemoteIpCameraFactory()],
    child: RemoteWidget(...)
)
``` 

Then you can provide a JSON representation of a color picker like this:

```
{
    'type': 'camera',
    'id': 'camera',
    'stream': 'http://domain.com/stream',
    'preview': 'http://domain.com/preview'
}
```

## API
Image button:

`id` : id of the widget
`value` : current value, it has to match one of the `values` entries
`width` : width of the button
`height`: height of the button
`fit`: fit, default to contain (1), see BoxFit for more
`padding`: padding of the button, see EdgeInsets definition
`values`: map of possible value


[remote_ui]: https://github.com/jaumard/remote_ui/tree/master/packages/remote_ui
