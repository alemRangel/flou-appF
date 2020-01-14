import 'package:learning/data/data.dart';

class FetchResourceAction {
  final String resourceId;

  FetchResourceAction(this.resourceId);
}

class FetchResourceSucceededAction {
  final LResource resource;

  FetchResourceSucceededAction(this.resource);
}

class FetchResourceFailedAction {
  final Exception error;

  FetchResourceFailedAction(this.error);
}

class FetchCategoryAction {
  final String categoryId;

  FetchCategoryAction(this.categoryId);
}

class FetchCategorySucceededAction {
  final Category category;

  FetchCategorySucceededAction(this.category);
}

class FetchCategoryFailedAction {
  final Exception error;

  FetchCategoryFailedAction(this.error);
}

class FetchChaptersAction {
  final String resourceId;

  FetchChaptersAction(this.resourceId);
}

class FetchChaptersSucceededAction {
  final List<Chapter> chapters;

  FetchChaptersSucceededAction(this.chapters);
}

class FetchChaptersFailedAction {
  final Exception error;

  FetchChaptersFailedAction(this.error);
}

class FetchEnrollmentAction {
  final String resourceId;

  FetchEnrollmentAction(this.resourceId);
}

class FetchEnrollmentSucceededAction {
  final Enrollment enrollment;

  FetchEnrollmentSucceededAction(this.enrollment);
}

class FetchEnrollmentFailedAction {
  final Exception error;

  FetchEnrollmentFailedAction(this.error);
}

class EnrollToResourceAction {
  final String resourceId;

  EnrollToResourceAction(this.resourceId);
}

class EnrollToResourceSucceededAction {
  final Enrollment enrollment;

  EnrollToResourceSucceededAction(this.enrollment);
}

class EnrollToResourceFailedAction {
  final Exception error;

  EnrollToResourceFailedAction(this.error);
}
