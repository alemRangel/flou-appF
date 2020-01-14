import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

@immutable
class ResourceState {
  final Category category;
  final LResource resource;
  final List<Chapter> chapters;
  final Enrollment enrollment;
  final LoadingStatus resourceLoadingStatus;
  final LoadingStatus chaptersLoadingStatus;
  final LoadingStatus enrollmentLoadingStatus;

  ResourceState({
    @required this.resourceLoadingStatus,
    @required this.chaptersLoadingStatus,
    @required this.category,
    @required this.resource,
    @required this.chapters,
    @required this.enrollment,
    @required this.enrollmentLoadingStatus,
  });

  factory ResourceState.initial() {
    return ResourceState(
      resourceLoadingStatus: LoadingStatus.loading,
      chaptersLoadingStatus: LoadingStatus.loading,
      category: null,
      resource: null,
      chapters: [],
      enrollment: null,
      enrollmentLoadingStatus: LoadingStatus.loading,
    );
  }

  ResourceState copyWith({
    LoadingStatus resourceLoadingStatus,
    LoadingStatus chaptersLoadingStatus,
    LoadingStatus enrollmentLoadingStatus,
    Category category,
    LResource resource,
    List<Chapter> chapters,
    Enrollment enrollment,
    bool enrollmentNull = false,
  }) {
    return ResourceState(
      resourceLoadingStatus:
          resourceLoadingStatus ?? this.resourceLoadingStatus,
      chaptersLoadingStatus:
          chaptersLoadingStatus ?? this.chaptersLoadingStatus,
      category: category ?? this.category,
      resource: resource ?? this.resource,
      chapters: chapters ?? this.chapters,
      enrollment: enrollmentNull ? null : (enrollment ?? this.enrollment),
      enrollmentLoadingStatus:
          enrollmentLoadingStatus ?? this.enrollmentLoadingStatus,
    );
  }

  @override
  int get hashCode =>
      resourceLoadingStatus.hashCode ^
      chaptersLoadingStatus.hashCode ^
      category.hashCode ^
      resource.hashCode ^
      chapters.hashCode ^
      enrollment.hashCode ^
      enrollmentLoadingStatus.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResourceState &&
          runtimeType == other.runtimeType &&
          resourceLoadingStatus == other.resourceLoadingStatus &&
          chaptersLoadingStatus == other.chaptersLoadingStatus &&
          category == other.category &&
          resource == other.resource &&
          chapters == other.chapters &&
          enrollment == other.enrollment &&
          enrollmentLoadingStatus == other.enrollmentLoadingStatus;

  @override
  String toString() {
    return '''ResourceState{
    resourceLoadingStatus: $resourceLoadingStatus,
    chaptersLoadingStatus: $chaptersLoadingStatus,
    category: $category,
    resource: $resource,
    chapters: $chapters,
    enrollment: $enrollment,
    enrollmentLoadingStatus: $enrollmentLoadingStatus,
    }''';
  }
}
