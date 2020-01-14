import 'package:learning/data/data.dart';

class FetchFeaturedAction<T extends ResourceType> {
  final T type;

  FetchFeaturedAction(this.type);
}

class FetchFeaturedSucceededAction<T extends ResourceType> {
  final T type;
  final List<LResource> featured;

  FetchFeaturedSucceededAction(this.type, this.featured);
}

class FetchFeaturedFailedAction<T extends ResourceType> {
  final T type;
  final Exception error;

  FetchFeaturedFailedAction(this.type, this.error);
}

class FetchRecentAction<T extends ResourceType> {
  final T type;

  FetchRecentAction(this.type);
}

class FetchRecentSucceededAction<T extends ResourceType> {
  final T type;
  final List<LResource> recent;

  FetchRecentSucceededAction(this.type, this.recent);
}

class FetchRecentFailedAction<T extends ResourceType> {
  final T type;
  final Exception error;

  FetchRecentFailedAction(this.type, this.error);
}

class FetchCategoriesAction<T extends ResourceType> {
  final T type;

  FetchCategoriesAction(this.type);
}

class FetchCategoriesSucceededAction<T extends ResourceType> {
  final T type;
  final List<Category> categories;

  FetchCategoriesSucceededAction(this.type, this.categories);
}

class FetchCategoriesFailedAction<T extends ResourceType> {
  final T type;
  final Exception error;

  FetchCategoriesFailedAction(this.type, this.error);
}

class FetchEnrollmentsAction<T extends ResourceType> {
  final T type;

  FetchEnrollmentsAction(this.type);
}

class FetchEnrollmentsSucceededAction<T extends ResourceType> {
  final T type;
  final List<Enrollment> enrollments;

  FetchEnrollmentsSucceededAction(this.type, this.enrollments);
}

class FetchEnrollmentsFailedAction<T extends ResourceType> {
  final T type;
  final Exception error;

  FetchEnrollmentsFailedAction(this.type, this.error);
}
