import 'package:flutter/material.dart';
import 'package:learning/utils/assets.dart';

class AudioImage extends StatefulWidget {
  final String imageUrl;
  final Duration position;
  final Duration duration;

  AudioImage({this.imageUrl, this.duration, this.position});

  @override
  AlbumUIState createState() => AlbumUIState();
}

class AlbumUIState extends State<AudioImage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.elasticOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cover = Material(
      borderRadius: BorderRadius.circular(15.0),
      elevation: 5.0,
      child: widget.imageUrl != null
          ? Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              height: 250.0,
              width: 250.0,
              gaplessPlayback: true,
            )
          : Image.asset(
              ImageAssets.placeholderImage,
              fit: BoxFit.cover,
              height: 250.0,
              width: 250.0,
              gaplessPlayback: false,
            ),
    );

    return SizedBox.fromSize(
      size: Size(animation.value * 250.0, animation.value * 250.0),
      child: Stack(
        children: <Widget>[
          cover,
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(horizontal: 0.8),
            child: Material(
              borderRadius: BorderRadius.circular(5.0),
              child: Stack(children: [
                LinearProgressIndicator(
                    value: 1.0,
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).buttonColor)),
                LinearProgressIndicator(
                  value: widget.position != null &&
                          widget.duration != null &&
                          widget.position.inMilliseconds > 0
                      ? (widget.position?.inMilliseconds?.toDouble() ?? 0.0) /
                          (widget.duration?.inMilliseconds?.toDouble() ?? 0.0)
                      : 0.0,
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).cardColor),
                  backgroundColor: Theme.of(context).buttonColor,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
