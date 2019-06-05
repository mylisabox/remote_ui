# remote_image_button

Flutter widget to manage an image button UI from a JSON definition

## Usage

Add the factory to the RemoteManagerWidget:

```
RemoteManagerWidget(
    parsers: [RemoteImageButtonFactory()],
    child: RemoteWidget(...)
)
``` 

`RemoteImageButtonFactory` can take a base url provider function, in case you definition contains only `/image/on.jpg` the base url will be taken from the provider

Then you can provide a JSON representation of a color picker like this:

```
{
    'type': 'image_button',
    'id': 'myButton',
    'value': 'on',
    'values': {
      'on': 'http://chittagongit.com/download/17966',
      'off': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRS1i8ftLBJX74FnwordRN5vQ5IgUy9rjkR1R2ODiBjWZThKoEHA',
    }
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


