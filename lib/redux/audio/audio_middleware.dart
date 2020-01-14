import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/audio/audio_actions.dart';
import 'package:learning/utils/cache.dart';
import 'package:redux/redux.dart';

class AudioMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is InitAudioPlayerAction) {
      _loadCacheFile(store, action.audioUrl);
    } else if (action is AudioPlayAction) {
      store.state.audioState.audioPlayer.play(action.audioUrl);
    } else if (action is AudioStopAction) {
      store.state.audioState.audioPlayer.stop();
    } else if (action is AudioPauseAction) {
      store.state.audioState.audioPlayer.pause();
    } else if (action is AudioSeekAction) {
      store.state.audioState.audioPlayer.seek(action.seconds);
    } else if (action is AudioUrlLoadedAction) {
      _subscribe(store);
    }

    next(action);
  }
}

void _loadCacheFile(Store<AppState> store, String audioUrl) async {
  var file = await Cache.getCacheFile(audioUrl);
  if (file == null) {
    store.dispatch(AudioUrlLoadedAction(audioUrl));
    store.dispatch(AudioPlayAction(audioUrl));
  } else {
    store.dispatch(AudioUrlLoadedAction(file.path));
    store.dispatch(AudioPlayAction(file.path));
  }
  store.dispatch(ChangeAudioStateAction(PlayerState.playing));
}

void _subscribe(Store<AppState> store) {
  store.state.audioState.audioPlayer.onAudioPositionChanged
      .listen((p) => store.dispatch(AudioPositionChanged(p)));

  store.state.audioState.audioPlayer.onPlayerStateChanged.listen((state) {},
      onError: (msg) {
    store.dispatch(AudioStopAction());
  });
}
