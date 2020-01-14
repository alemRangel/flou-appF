import 'package:audioplayer/audioplayer.dart';
import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

@immutable
class AudioState {
  final AudioPlayer audioPlayer;
  final String audioUrl;
  final String imageUrl;
  final String label;
  final PlayerState playerState;
  final LoadingStatus cacheLoadingStatus;
  final Duration position;

  AudioState({
    @required this.audioUrl,
    @required this.playerState,
    @required this.imageUrl,
    @required this.label,
    @required this.cacheLoadingStatus,
    @required this.audioPlayer,
    @required this.position,
  });

  factory AudioState.initial() {
    return AudioState(
      audioPlayer: AudioPlayer(),
      audioUrl: null,
      imageUrl: null,
      label: null,
      playerState: PlayerState.stopped,
      cacheLoadingStatus: LoadingStatus.loading,
      position: null,
    );
  }

  AudioState copyWith({
    AudioPlayer audioPlayer,
    String audioUrl,
    String imageUrl,
    String label,
    PlayerState playerState,
    LoadingStatus cacheLoadingStatus,
    Duration duration,
    Duration position,
  }) {
    return AudioState(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      label: label ?? this.label,
      playerState: playerState ?? this.playerState,
      cacheLoadingStatus: cacheLoadingStatus ?? this.cacheLoadingStatus,
      position: position ?? this.position,
    );
  }

  @override
  int get hashCode =>
      audioPlayer.hashCode ^
      audioUrl.hashCode ^
      imageUrl.hashCode ^
      label.hashCode ^
      playerState.hashCode ^
      cacheLoadingStatus.hashCode ^
      position.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioState &&
          runtimeType == other.runtimeType &&
          audioPlayer == other.audioPlayer &&
          audioUrl == other.audioUrl &&
          imageUrl == other.imageUrl &&
          label == other.label &&
          playerState == other.playerState &&
          cacheLoadingStatus == other.cacheLoadingStatus &&
          position == other.position;

  @override
  String toString() {
    return 'AudioState{audioPlayer: $audioPlayer, audioUrl: $audioUrl, imageUrl: $imageUrl, label: $label, playerState: $playerState, cacheLoadingStatus: $cacheLoadingStatus}';
  }
}
