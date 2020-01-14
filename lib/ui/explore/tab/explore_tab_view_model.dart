import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/explore/explore_actions.dart';
import 'package:learning/redux/explore/explore_selectors.dart';
import 'package:learning/redux/explore/explore_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class ExploreTabViewModel<T extends ResourceType> {
  ExploreTabViewModel({
    @required this.exploreState,
    @required this.refreshFeatured,
    @required this.refreshRecent,
    @required this.refreshCategories,
    @required this.resourceSelected,
    @required this.categorySelected,
    @required this.navigateTo,
  });

  final ExploreState exploreState;
  final Function refreshFeatured;
  final Function refreshRecent;
  final Function refreshCategories;
  final Function resourceSelected;
  final Function categorySelected;
  final Function navigateTo;

  static ExploreTabViewModel<E> fromStore<E extends ResourceType>(
      Store<AppState> store, E type) {
    return ExploreTabViewModel(
      exploreState: exploreSelector(store.state, type),
      refreshFeatured: (ResourceType key) =>
          store.dispatch(FetchFeaturedAction(key)),
      refreshRecent: (ResourceType key) =>
          store.dispatch(FetchRecentAction(key)),
      refreshCategories: (ResourceType key) =>
          store.dispatch(FetchCategoriesAction(key)),
      resourceSelected: (String id) => store.dispatch(
            NavigateAction("/resources/$id"),
          ),
      categorySelected: (String categoryId) => store.dispatch(
            NavigateAction(
              "/resources?type=${type.queryString()}&categoryId=$categoryId",
            ),
          ),
      navigateTo: (String route) => store.dispatch(NavigateAction(route)),
    );
  }

  List<Category> get categories => exploreState.categories;
  List<LResource> get featured => exploreState.featured;
  List<LResource> get recent => exploreState.recent;
  LoadingStatus get categoriesLoadingStatus =>
      exploreState.categoriesLoadingStatus;
  LoadingStatus get featuredLoadingStatus => exploreState.featuredLoadingStatus;
  LoadingStatus get recentLoadingStatus => exploreState.recentLoadingStatus;
  T get type => exploreState.type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExploreTabViewModel &&
          runtimeType == other.runtimeType &&
          exploreState == other.exploreState &&
          refreshFeatured == other.refreshFeatured &&
          refreshRecent == other.refreshRecent &&
          refreshCategories == other.refreshCategories &&
          resourceSelected == other.resourceSelected &&
          categorySelected == other.categorySelected &&
          navigateTo == other.navigateTo;

  @override
  int get hashCode =>
      exploreState.hashCode ^
      refreshFeatured.hashCode ^
      refreshRecent.hashCode ^
      refreshCategories.hashCode ^
      resourceSelected.hashCode ^
      categorySelected.hashCode ^
      navigateTo.hashCode;
}
