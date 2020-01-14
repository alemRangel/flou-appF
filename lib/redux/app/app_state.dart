import 'package:learning/data/data.dart';
import 'package:learning/redux/audio/audio_state.dart';
import 'package:learning/redux/auth/auth_state.dart';
import 'package:learning/redux/cached_files/cached_files_state.dart';
import 'package:learning/redux/chapter/chapter_state.dart';
import 'package:learning/redux/explore/explore_state.dart';
import 'package:learning/redux/resource/resource_state.dart';
import 'package:learning/redux/resource_list/resource_list_state.dart';
import 'package:learning/redux/search/search_state.dart';
import 'package:learning/redux/spotlight/spotlight_state.dart';
import 'package:learning/redux/subscription/subscription_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({
    @required this.audioState,
    @required this.authState,
    @required this.spotlightState,
    @required this.resourceState,
    @required this.chapterState,
    @required this.exploreCoursesState,
    @required this.exploreMeditationsState,
    @required this.exploreBooksState,
    @required this.listResourcesState,
    @required this.searchState,
    @required this.cachedFilesState,
    @required this.subscriptionState,
  });

  final AudioState audioState;
  final AuthState authState;
  final SpotlightState spotlightState;
  final ResourceState resourceState;
  final ChapterState chapterState;
  final ExploreState<CourseResource> exploreCoursesState;
  final ExploreState<MeditationResource> exploreMeditationsState;
  final ExploreState<BookResource> exploreBooksState;
  final ResourceListState listResourcesState;
  final SearchState<LResource> searchState;
  final SubscriptionState subscriptionState;
  final CachedFilesState cachedFilesState;

  factory AppState.initial() {
    return AppState(
      audioState: AudioState.initial(),
      authState: AuthState.initial(),
      spotlightState: SpotlightState.initial(),
      resourceState: ResourceState.initial(),
      chapterState: ChapterState.initial(),
      exploreCoursesState: ExploreState.initial(CourseResource()),
      exploreMeditationsState: ExploreState.initial(MeditationResource()),
      exploreBooksState: ExploreState.initial(BookResource()),
      listResourcesState: ResourceListState.initial(),
      searchState: SearchState.initial(LResource()),
      subscriptionState: SubscriptionState.initial(),
      cachedFilesState: CachedFilesState.initial(),
    );
  }

  AppState copyWith({
    AudioState audioState,
    AuthState authState,
    SpotlightState spotlightState,
    ResourceState resourceState,
    ChapterState chapterState,
    ExploreState<CourseResource> coursesState,
    ExploreState<MeditationResource> meditationsState,
    ExploreState<BookResource> booksState,
    ResourceListState listResourcesState,
    SearchState<LResource> searchState,
    SubscriptionState subscriptionState,
    CachedFilesState cachedFilesState,
  }) {
    return AppState(
      audioState: audioState ?? this.audioState,
      authState: authState ?? this.authState,
      spotlightState: spotlightState ?? this.spotlightState,
      resourceState: resourceState ?? this.resourceState,
      chapterState: chapterState ?? this.chapterState,
      exploreCoursesState: coursesState ?? this.exploreCoursesState,
      exploreMeditationsState: meditationsState ?? this.exploreMeditationsState,
      exploreBooksState: booksState ?? this.exploreBooksState,
      listResourcesState: listResourcesState ?? this.listResourcesState,
      searchState: searchState ?? this.searchState,
      subscriptionState: subscriptionState ?? this.subscriptionState,
      cachedFilesState: cachedFilesState ?? this.cachedFilesState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          audioState == other.audioState &&
          authState == other.authState &&
          spotlightState == other.spotlightState &&
          resourceState == other.resourceState &&
          chapterState == other.chapterState &&
          exploreCoursesState == other.exploreCoursesState &&
          exploreMeditationsState == other.exploreMeditationsState &&
          exploreBooksState == other.exploreBooksState &&
          listResourcesState == other.listResourcesState &&
          searchState == other.searchState &&
          subscriptionState == other.subscriptionState &&
          cachedFilesState == other.cachedFilesState;

  @override
  int get hashCode =>
      audioState.hashCode ^
      authState.hashCode ^
      spotlightState.hashCode ^
      resourceState.hashCode ^
      chapterState.hashCode ^
      exploreCoursesState.hashCode ^
      exploreMeditationsState.hashCode ^
      exploreBooksState.hashCode ^
      listResourcesState.hashCode ^
      searchState.hashCode ^
      subscriptionState.hashCode ^
      cachedFilesState.hashCode;

  @override
  String toString() {
    return '''AppState{
    audioState: $audioState,
    authState: $authState,
    spotlightState: $spotlightState,
    resourceState: $resourceState,
    chapterState: $chapterState,
    exploreCoursesState: $exploreCoursesState,
    exploreMeditationsState: $exploreMeditationsState,
    exploreBooksState: $exploreBooksState
    listResourcesState: $listResourcesState,
    searchstate: $searchState,
    subsccriptionState: $subscriptionState,
    cachedFilesState: $cachedFilesState,
    }''';
  }
}
