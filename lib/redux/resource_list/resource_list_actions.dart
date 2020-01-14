import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

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

class FetchResourcesAction {
  final ResourceType type;
  final String categoryId;

  FetchResourcesAction({@required this.type, this.categoryId});
}

class FetchResourcesSucceededAction {
  final ResourceType type;
  final List<LResource> resources;

  FetchResourcesSucceededAction(this.type, this.resources);
}

class FetchResourcesFailedAction {
  final ResourceType type;
  final Exception error;

  FetchResourcesFailedAction(this.type, this.error);
}
