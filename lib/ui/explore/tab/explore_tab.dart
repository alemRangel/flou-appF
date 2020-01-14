import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/explore/explore_actions.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/explore/tab/explore_tab_view_model.dart';
import 'package:learning/ui/explore/widget/category_list.dart';

typedef Widget BuildContent();

class ExploreTab<T extends ResourceType> extends StatelessWidget {
  final T type;

  ExploreTab({this.type});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExploreTabViewModel<T>>(
      onInit: (store) {
        store.dispatch(FetchFeaturedAction(type));
        store.dispatch(FetchRecentAction(type));
        store.dispatch(FetchCategoriesAction(type));
      },
      distinct: true,
      converter: (store) => ExploreTabViewModel.fromStore<T>(store, type),
      builder: (_, viewModel) => ExplorePageContent(viewModel),
    );
  }
}

class ExplorePageContent extends StatelessWidget {
  final ExploreTabViewModel viewModel;

  ExplorePageContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 8.0),
                SectionTitle(label: 'Popular'),
                _buildFeaturedList(),
                SectionTitle(label: 'Recientes'),
                _buildRecentList(),
                SectionTitle(label: 'Categorias'),
                _buildCategoriesList(),
              ]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedList() {
    return LoadingView(
      status: viewModel.featuredLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Hubo un problema cargando el recurso.',
        onRetry: () => viewModel.refreshFeatured(viewModel.type),
      ),
      successContent: ResourceHorizontalList(
        resources: viewModel.featured,
        onReloadCallback: () => viewModel.refreshFeatured(viewModel.type),
        onItemSelected: (resource) => viewModel.resourceSelected(resource.id),
      ),
    );
  }

  Widget _buildRecentList() {
    return LoadingView(
      status: viewModel.recentLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'No pudimos cargar los capítulos.',
        onRetry: () => viewModel.refreshRecent(viewModel.type),
      ),
      successContent: ResourceHorizontalList(
        resources: viewModel.recent,
        onReloadCallback: () => viewModel.refreshRecent(viewModel.type),
        onItemSelected: (resource) => viewModel.resourceSelected(resource.id),
      ),
    );
  }

  Widget _buildCategoriesList() {
    return LoadingView(
      status: viewModel.categoriesLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'No pudimos cargar los capítulos.',
        onRetry: () => viewModel.refreshCategories(viewModel.type),
      ),
      successContent: CategoryList(
        categories: viewModel.categories,
        onReloadCallback: () => viewModel.refreshCategories(viewModel.type),
        onItemSelected: (category) => viewModel.categorySelected(category.id),
      ),
    );
  }
}
