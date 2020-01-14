import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/resource_list/resource_list_actions.dart';
import 'package:learning/redux/resource_list/resource_list_state.dart';
import 'package:learning/redux/navigation/navigation_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class ResourceListViewModel {
  ResourceListViewModel({
    @required this.resourceListState,
    @required this.refreshResources,
    @required this.resourceSelected,
  });

  final ResourceListState resourceListState;
  final Function refreshResources;
  final Function resourceSelected;

  static ResourceListViewModel fromStore(
      Store<AppState> store, ResourceType type) {
    return ResourceListViewModel(
      resourceListState: store.state.listResourcesState,
      refreshResources: (ResourceType type, String categoryId) => store
          .dispatch(FetchResourcesAction(type: type, categoryId: categoryId)),
      resourceSelected: (String id) => store.dispatch(
            NavigateAction('/resources/$id'),
          ),
    );
  }

  Category get category => resourceListState.category;
  List<LResource> get resources => resourceListState.resources;
  LoadingStatus get categoryLoadingStatus =>
      resourceListState.categoryLoadingStatus;
  LoadingStatus get resourcesLoadingStatus =>
      resourceListState.resourcesLoadingStatus;
  ResourceType get type => resourceListState.type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResourceListViewModel &&
          runtimeType == other.runtimeType &&
          resourceListState == other.resourceListState &&
          refreshResources == other.refreshResources &&
          resourceSelected == other.resourceSelected;

  @override
  int get hashCode =>
      resourceListState.hashCode ^
      refreshResources.hashCode ^
      resourceSelected.hashCode;
}
