import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/audio/audio_reducer.dart';
import 'package:learning/redux/auth/auth_reducer.dart';
import 'package:learning/redux/cached_files/cached_files_reducer.dart';
import 'package:learning/redux/chapter/chapter_reducer.dart';
import 'package:learning/redux/explore/explore_reducer.dart';
import 'package:learning/redux/resource/resource_reducer.dart';
import 'package:learning/redux/resource_list/resource_list_reducer.dart';
import 'package:learning/redux/search/search_reducer.dart';
import 'package:learning/redux/subscription/subscription_reducer.dart';
import 'package:learning/redux/spotlight/spotlight_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    audioState: audioReducer(state.audioState, action),
    authState: authReducer(state.authState, action),
    spotlightState: spotlightReducer(state.spotlightState, action),
    resourceState: resourceReducer(state.resourceState, action),
    chapterState: chapterReducer(state.chapterState, action),
    listResourcesState: resourceListReducer(state.listResourcesState, action),
    exploreCoursesState: ExploreReducer<CourseResource>()
        .reducer(state.exploreCoursesState, action),
    exploreMeditationsState: ExploreReducer<MeditationResource>()
        .reducer(state.exploreMeditationsState, action),
    exploreBooksState:
        ExploreReducer<BookResource>().reducer(state.exploreBooksState, action),
    searchState: SearchReducer<LResource>().reducer(state.searchState, action),
    subscriptionState: subscriptionReducer(state.subscriptionState, action),
    cachedFilesState: cachedFilesReducer(state.cachedFilesState, action),
  );
}
