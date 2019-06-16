import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class IpCamera extends HookWidget {
  final String stream;
  final String preview;
  final String id;
  final double width;
  final double height;
  final BoxFit fit;
  final Color color;

  IpCamera({
    this.width,
    this.color,
    this.fit,
    this.height,
    this.stream,
    this.preview,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final isPlaying = useState(false);
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
                onPressed: () {},
                color: color,
                icon: Icon(Icons.refresh),
              ),
          ],
        ),
        Expanded(
          child: isPlaying.value
              ? Mjpeg(
                  stream: stream,
                  fit: fit,
                  width: width,
                  height: height,
                )
              : preview == null
                  ? Container()
                  : Image.network(
                      preview,
                      fit: fit,
                    ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return Stack(
                    children: [
                      Center(
                        child: Mjpeg(
                          stream: stream,
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
