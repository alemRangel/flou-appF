import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/explore/explore_state.dart';

ExploreState exploreSelector(AppState state, ResourceType type) {
  if (type is CourseResource) {
    return state.exploreCoursesState;
  } else if (type is MeditationResource) {
    return state.exploreMeditationsState;
  } else {
    return state.exploreBooksState;
  }
}
