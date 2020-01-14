import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

@immutable
class ResourceListState {
  final Category category;
  final LoadingStatus categoryLoadingStatus;
  final List<LResource> resources;
  final LoadingStatus resourcesLoadingStatus;
  final ResourceType type;

  ResourceListState({
    @required this.category,
    @required this.categoryLoadingStatus,
    @required this.resources,
    @required this.resourcesLoadingStatus,
    @required this.type,
  });

  factory ResourceListState.initial() {
    return ResourceListState(
      category: null,
      categoryLoadingStatus: LoadingStatus.loading,
      resources: [],
      resourcesLoadingStatus: LoadingStatus.loading,
      type:
          CourseResource(), // Doesn't matter which type is initial as it gets replaced
    );
  }

  ResourceListState copyWith({
    Category category,
    LoadingStatus categoryLoadingStatus,
    List<LResource> resources,
    LoadingStatus resourcesLoadingStatus,
    ResourceType type,
  }) {
    return ResourceListState(
      category: category ?? this.category,
      categoryLoadingStatus:
          categoryLoadingStatus ?? this.categoryLoadingStatus,
      resources: resources ?? this.resources,
      resourcesLoadingStatus:
          resourcesLoadingStatus ?? this.resourcesLoadingStatus,
      type: type ?? this.type,
    );
  }

  @override
  int get hashCode =>
      resources.hashCode ^
      resourcesLoadingStatus.hashCode ^
      category.hashCode ^
      categoryLoadingStatus.hashCode ^
      type.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResourceListState &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          categoryLoadingStatus == other.categoryLoadingStatus &&
          resources == other.resources &&
          resourcesLoadingStatus == other.resourcesLoadingStatus &&
          type == other.type;

  @override
  String toString() {
    return '''ResourceListState<${type.runtimeType}>{
    category: $category,
    categoryLoadingStatus: $categoryLoadingStatus,
    resources: $resources,
    resourcesLoadingStatus: $resourcesLoadingStatus,
    type: $type,
    }''';
  }
}
