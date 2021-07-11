import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class IpCamera extends HookWidget {
  final String Function() baseUrlProvider;
  final String stream;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const IpCamera({
    this.width,
    required this.baseUrlProvider,
    this.color,
    required this.fit,
    this.height,
    required this.stream,
  });

  @override
  Widget build(BuildContext context) {
    final isPlaying = useState(false);
    final streamState = useState(stream);
    final urlProvider = baseUrlProvider;

    useEffect(() {
      streamState.value = urlProvider() + stream;
      return null;
    }, [stream]);

    final color = this.color ?? Theme.of(context).primaryColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              onPressed: () {
                isPlaying.value = !isPlaying.value;
              },
              color: color,
              icon: Icon(isPlaying.value ? Icons.pause : Icons.play_arrow),
            ),
            if (!isPlaying.value)
              IconButton(
                onPressed: () {
                  streamState.value =
                      '${streamState.value}?timestamp=${DateTime.now().millisecondsSinceEpoch}';
                },
                color: color,
                icon: Icon(Icons.refresh),
              ),
          ],
        ),
        Expanded(
          child: Mjpeg(
            stream: streamState.value,
            fit: fit,
            isLive: isPlaying.value,
            width: width,
            height: height,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Stack(
                    children: [
                      Center(
                        child: Mjpeg(
                          stream: streamState.value,
                          isLive: true,
                          fit: fit,
                        ),
                      ),
                      Material(
                        clipBehavior: Clip.none,
                        color: Colors.transparent,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: BackButton(color: color),
                          ),
                        ),
                      ),
                    ],
                  );
                }));
              },
              color: color,
              icon: Icon(Icons.fullscreen),
            ),
          ],
        ),
      ],
    );
  }
}
