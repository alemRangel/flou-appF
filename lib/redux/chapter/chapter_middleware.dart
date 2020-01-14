import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/api/api.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/chapter/chapter_actions.dart';
import 'package:learning/redux/interaction/interaction_actions.dart';
import 'package:learning/utils/cache.dart';
import 'package:redux/redux.dart';

class ChapterMiddleware extends MiddlewareClass<AppState> {
  ChapterEndpoint chapterEndpoint;

  ChapterMiddleware(this.chapterEndpoint);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is FetchChapterAction) {
       // chapterEndpoint.getTest("0").then((Chapter chapter) async {
        chapterEndpoint.get(action.chapterKey).then((Chapter chapter) async {
        chapter.offlineVideoPath = await _getCachePath(chapter.downloadVideoUrl);
        chapter.offlineAudioPath = await _getCachePath(chapter.audioUrl);
        store.dispatch(FetchChapterSucceededAction(chapter));
        _createInteraction(store, chapter, store.state.authState.user.uid);
      }).catchError((error) {
        store.dispatch(FetchChapterFailedAction(error));
      });
    }
    next(action);
  }
}

Future<String> _getCachePath(String url) async {
  var file = await Cache.getCacheFile(url);
  if (file != null) {
    return file.path;
  }
  return null;
}

/* Fix Me: Should have a separate context object for this */
void _createInteraction(
    Store<AppState> store, Chapter chapter, String userId) async {
  Map<String, dynamic> data = {
    'resourceId': chapter.resourceId,
    'chapterId': chapter.id,
    'action': 'chapter:open',
    'userId': userId,
    'happenedAt': FieldValue.serverTimestamp(),
  };
  store.dispatch(CreateInteractionAction(data));
}
