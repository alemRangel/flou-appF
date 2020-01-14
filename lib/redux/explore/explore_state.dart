import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

@immutable
class ExploreState<T extends ResourceType> {
  final List<Category> categories;
  final List<Enrollment> enrollments;
  final List<LResource> featured;
  final List<LResource> recent;
  final LoadingStatus categoriesLoadingStatus;
  final LoadingStatus enrollmentsLoadingStatus;
  final LoadingStatus featuredLoadingStatus;
  final LoadingStatus recentLoadingStatus;
  final T type;

  ExploreState({
    @required this.categories,
    @required this.categoriesLoadingStatus,
    @required this.featured,
    @required this.featuredLoadingStatus,
    @required this.recent,
    @required this.recentLoadingStatus,
    @required this.enrollments,
    @required this.enrollmentsLoadingStatus,
    @required this.type,
  });

  factory ExploreState.initial(T type) {
    return ExploreState(
      categories: [],
      categoriesLoadingStatus: LoadingStatus.loading,
      enrollments: [],
      enrollmentsLoadingStatus: LoadingStatus.loading,
      featured: [],
      featuredLoadingStatus: LoadingStatus.loading,
      recent: [],
      recentLoadingStatus: LoadingStatus.loading,
      type: type,
    );
  }

  ExploreState<T> copyWith({
    List<Category> categories,
    LoadingStatus categoriesLoadingStatus,
    List<Enrollment> enrollments,
    LoadingStatus enrollmentsLoadingStatus,
    List<LResource> featured,
    LoadingStatus featuredLoadingStatus,
    List<LResource> recent,
    LoadingStatus recentLoadingStatus,
    T type,
  }) {
    return ExploreState<T>(
      categories: categories ?? this.categories,
      categoriesLoadingStatus:
          categoriesLoadingStatus ?? this.categoriesLoadingStatus,
      enrollments: enrollments ?? this.enrollments,
      enrollmentsLoadingStatus:
          enrollmentsLoadingStatus ?? this.enrollmentsLoadingStatus,
      featured: featured ?? this.featured,
      featuredLoadingStatus:
          featuredLoadingStatus ?? this.featuredLoadingStatus,
      recent: recent ?? this.recent,
      recentLoadingStatus: recentLoadingStatus ?? this.recentLoadingStatus,
      type: type ?? this.type,
    );
  }

  @override
  int get hashCode =>
      categories.hashCode ^
      categoriesLoadingStatus.hashCode ^
      enrollments.hashCode ^
      enrollmentsLoadingStatus.hashCode ^
      featured.hashCode ^
      featuredLoadingStatus.hashCode ^
      recent.hashCode ^
      recentLoadingStatus.hashCode ^
      type.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExploreState &&
          runtimeType == other.runtimeType &&
          categories == other.categories &&
          categoriesLoadingStatus == other.categoriesLoadingStatus &&
          enrollments == other.enrollments &&
          enrollmentsLoadingStatus == other.enrollmentsLoadingStatus &&
          featured == other.featured &&
          featuredLoadingStatus == other.featuredLoadingStatus &&
          recent == other.recent &&
          recentLoadingStatus == other.recentLoadingStatus &&
          type == other.type;

  @override
  String toString() {
    return '''ExploreState<${type.runtimeType}>{
    categories: $categories,
    categoriesLoadingStatus: $categoriesLoadingStatus,
    enrollments: $enrollments,
    enrollmentsLoadingStatus: $enrollmentsLoadingStatus,
    featured: $featured,
    featuredLoadingStatus: $featuredLoadingStatus,
    recent: $recent,
    recentLoadingStatus: $recentLoadingStatus,
    type: $type
    }''';
  }
}
