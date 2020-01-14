import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

class InitAudioPlayerAction {
  final String audioUrl;
  final String imageUrl;
  final String label;

  InitAudioPlayerAction({@required this.audioUrl, this.imageUrl, this.label});
}

class AudioUrlLoadedAction {
  final String audioUrl;

  AudioUrlLoadedAction(this.audioUrl);
}

class ChangeAudioStateAction {
  final PlayerState playerState;

  ChangeAudioStateAction(this.playerState);
}

class AudioPlayAction {
  final String audioUrl;

  AudioPlayAction(this.audioUrl);
}

class AudioStopAction {}

class AudioPauseAction {}

class AudioSeekAction {
  final double seconds;

  AudioSeekAction(this.seconds);
}

class AudioPositionChanged {
  final Duration position;

  AudioPositionChanged(this.position);
}
