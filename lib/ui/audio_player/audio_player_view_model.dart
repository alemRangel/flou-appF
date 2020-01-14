import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/audio/audio_actions.dart';
import 'package:learning/redux/audio/audio_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AudioPlayerViewModel {
  AudioPlayerViewModel({
    @required this.audioState,
    @required this.changePlayerState,
    @required this.play,
    @required this.stop,
    @required this.pause,
    @required this.seek,
  });

  final AudioState audioState;
  final Function changePlayerState;
  final Function play;
  final Function stop;
  final Function pause;
  final Function seek;

  static AudioPlayerViewModel fromStore(Store<AppState> store) {
    return AudioPlayerViewModel(
      audioState: store.state.audioState,
      changePlayerState: (PlayerState playerState) =>
          store.dispatch(ChangeAudioStateAction(playerState)),
      play: (String url) => store.dispatch(AudioPlayAction(url)),
      stop: () => store.dispatch(AudioStopAction()),
      pause: () => store.dispatch(AudioPauseAction()),
      seek: (double seconds) => store.dispatch(AudioSeekAction(seconds)),
    );
  }

  static onInit(Store<AppState> store,
      {String imageUrl, String audioUrl, String label}) {
    store.dispatch(
      InitAudioPlayerAction(
        audioUrl: audioUrl,
        imageUrl: imageUrl,
        label: label,
      ),
    );
  }

  static onDispose(Store<AppState> store,
      {String imageUrl, String audioUrl, String label}) {
    store.dispatch(AudioStopAction());
  }

  get audioUrl => audioState.audioUrl;
  get imageUrl => audioState.imageUrl;
  get label => audioState.label;
  get isPlaying => audioState.playerState == PlayerState.playing;
  get isPaused => audioState.playerState == PlayerState.paused;
  get isStopped => audioState.playerState == PlayerState.stopped;
  get cacheLoadingStatus => audioState.cacheLoadingStatus;
  get audioPlayer => audioState.audioPlayer;
  get position => audioState.position;
  get duration => audioState.audioPlayer.duration;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioPlayerViewModel &&
          runtimeType == other.runtimeType &&
          audioState == other.audioState &&
          changePlayerState == other.changePlayerState &&
          play == other.play &&
          pause == other.pause &&
          seek == other.seek &&
          stop == other.stop;

  @override
  int get hashCode =>
      audioState.hashCode ^
      changePlayerState.hashCode ^
      play.hashCode ^
      pause.hashCode ^
      seek.hashCode ^
      stop.hashCode;
}
