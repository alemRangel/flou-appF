import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/utils/widget_utils.dart';
import 'package:video_player/video_player.dart';

class ChapterContent extends StatelessWidget {
  final Chapter currentChapter;
  final LResource resource;

  ChapterContent({@required this.currentChapter, this.resource});

  @override
  Widget build(BuildContext context) {
    if (currentChapter == null) return Container();

    var content = <Widget>[];

    addIfNonNull(_buildVideoPlayer(), content);
    addIfNonNull(_buildText(context), content);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: content,
    );
  }

  Widget _buildText(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 32.0,
          ),
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    var themeData = Theme.of(context);
    return Theme(
      child: MarkdownBody(
        data: currentChapter.content,
      ),
      data: themeData.copyWith(
        textTheme: themeData.textTheme.copyWith(
          body1: themeData.textTheme.body1.copyWith(
            fontSize: 17.0,
            color: Colors.grey[800],
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (currentChapter.wistiaVideoId == null) return null;
    Widget player;
    if (currentChapter.offlineVideoPath != null) {
      player = _buildOfflinePlayer();
    } else {
      player = _buildPlayer();
    }
    return AspectRatio(aspectRatio: currentChapter.videoRatio, child: player);
  }

  Widget _buildPlayer() {
    return WistiaPlayer(
      key: Key(currentChapter.wistiaVideoId),
      videoId: currentChapter.wistiaVideoId,
    );
  }

  Widget _buildOfflinePlayer() {
    final videoPlayerController = VideoPlayerController.file(File(currentChapter.offlineVideoPath));
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16.0 / 9.0,
      autoInitialize: true,
      autoPlay: false,
      looping: false,
    );
    return Chewie(controller: chewieController);
  }
}
