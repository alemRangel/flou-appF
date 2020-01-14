import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learning/ui/audio_player/audio_player_page.dart';

final audioPlayerHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return AudioPlayerPage(
    audioUrl: params["audiourl"][0],
    label: params["label"][0],
    imageUrl: params["imageUrl"][0],
  );
});
