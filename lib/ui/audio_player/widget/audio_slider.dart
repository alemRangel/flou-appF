import 'package:flutter/material.dart';

class AudioSlider extends StatelessWidget {
  final String label;
  final Duration duration;
  final Duration position;
  final Function seekTo;

  AudioSlider(
      {@required this.duration,
      @required this.position,
      this.label,
      this.seekTo});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              label ?? "",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 6.0)),
            _buildSlider(),
            Padding(padding: EdgeInsets.only(bottom: 6.0)),
            _buildRemainingText(),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return duration == null
        ? Container()
        : Slider(
            value: position?.inMilliseconds?.toDouble() ?? 0.0,
            onChanged: (double value) => seekTo((value / 1000).roundToDouble()),
            min: 0.0,
            max: duration.inMilliseconds.toDouble(),
          );
  }

  Widget _buildRemainingText() {
    String durationText = "";
    if (duration != null && position != null) {
      final int minutes = (duration - position).inMinutes;
      final int seconds = (duration - position).inSeconds - minutes * 60;
      durationText = "${minutes}m ${seconds}s remaining";
    }

    return Text(
      durationText,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 14.0,
      ),
    );
  }
}
