import 'package:learning/data/data.dart';
import 'package:learning/redux/audio/audio_actions.dart';
import 'package:learning/redux/audio/audio_state.dart';
import 'package:redux/redux.dart';

final audioReducer = combineReducers<AudioState>([
  TypedReducer<AudioState, InitAudioPlayerAction>(_initPlayer),
  TypedReducer<AudioState, ChangeAudioStateAction>(_setState),
  TypedReducer<AudioState, AudioUrlLoadedAction>(_setAudioUrl),
  TypedReducer<AudioState, AudioPositionChanged>(_setPosition),
]);

AudioState _initPlayer(AudioState state, InitAudioPlayerAction action) {
  return state.copyWith(
    audioUrl: null,
    imageUrl: action.imageUrl,
    label: action.label,
    playerState: PlayerState.stopped,
  );
}

AudioState _setState(AudioState state, ChangeAudioStateAction action) {
  return state.copyWith(
    playerState: action.playerState,
  );
}

AudioState _setAudioUrl(AudioState state, AudioUrlLoadedAction action) {
  return state.copyWith(
    audioUrl: action.audioUrl,
    cacheLoadingStatus: LoadingStatus.success,
  );
}

AudioState _setPosition(AudioState state, AudioPositionChanged action) {
  return state.copyWith(
    position: action.position,
  );
}
