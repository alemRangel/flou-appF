import 'dart:async';
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/ui/audio_player/audio_player_view_model.dart';
import 'package:learning/ui/audio_player/widget/audio_image.dart';
import 'package:learning/ui/audio_player/widget/audio_slider.dart';
import 'package:learning/ui/common/common.dart';

typedef void OnError(Exception exception);

class AudioPlayerPage extends StatelessWidget {
  final String label;
  final String audioUrl;
  final String imageUrl;

  AudioPlayerPage({@required this.audioUrl, this.label, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AudioPlayerViewModel>(
      onInit: (store) => AudioPlayerViewModel.onInit(
            store,
            imageUrl: imageUrl,
            audioUrl: audioUrl,
            label: label,
          ),
      distinct: true,
      converter: (store) => AudioPlayerViewModel.fromStore(store),
      builder: (_, viewModel) => AudioPlayerPageContent(viewModel),
      onDispose: (store) => AudioPlayerViewModel.onDispose(store),
    );
  }
}

class AudioPlayerPageContent extends StatelessWidget {
  final AudioPlayerViewModel viewModel;

  AudioPlayerPageContent(this.viewModel);

  get isPlaying => viewModel.isPlaying;
  get isPaused => viewModel.isPaused;

  Future play() async {
    await viewModel.audioPlayer.play(viewModel.audioUrl);
    viewModel.changePlayerState(PlayerState.playing);
  }

  Future pause() async {
    await viewModel.audioPlayer.pause();
    viewModel.changePlayerState(PlayerState.paused);
  }

  Future stop() async {
    await viewModel.audioPlayer.stop();
    viewModel.changePlayerState(PlayerState.stopped);
  }

  Future rewind(int millis) async {
    viewModel.audioPlayer
        .seek((viewModel.position.inMilliseconds + millis) / 1000);
  }

  void onComplete() {
    viewModel.changePlayerState(PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _buildBackground(),
        _buildBlur(),
        _buildContent(context)
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _buildBackButton(context),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            AudioSlider(
              label: viewModel.label,
              duration: viewModel.duration,
              position: viewModel.position,
              seekTo: viewModel.audioPlayer.seek,
            ),
            AudioImage(
              imageUrl: viewModel.imageUrl,
              duration: viewModel.duration,
              position: viewModel.position,
            ),
            _buildControls(),
          ],
        )
      ],
    );
  }

  Widget _buildBackground() {
    return Image.network(
      viewModel.imageUrl,
      color: Colors.black54,
      fit: BoxFit.cover,
      colorBlendMode: BlendMode.darken,
    );
  }

  Widget _buildBlur() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.black87.withOpacity(0.1)),
      ),
    );
  }

  Widget _buildControls() {
    if (viewModel.duration == null) return _buildLoading();

    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
              onPressed: () => rewind(-30000),
              iconSize: 64.0,
              icon: Icon(Icons.fast_rewind),
              color: Colors.white,
            ),
            IconButton(
              onPressed: isPlaying ? pause : play,
              iconSize: 64.0,
              icon: Icon(isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_filled),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () => rewind(30000),
              iconSize: 64.0,
              icon: Icon(Icons.fast_forward),
              color: Colors.white,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 4.0,
      left: 8.0,
      child: Material(
        type: MaterialType.circle,
        color: Colors.transparent,
        child: IconButton(
          icon: Icon(isPlaying ? Icons.keyboard_arrow_down : Icons.close),
          iconSize: isPlaying ? 40.0 : 28.0,
          color: Colors.white,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const PlatformAdaptiveProgressIndicator();
  }
}
