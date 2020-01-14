import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/resource_list/resource_list_actions.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/resource_list/resource_list_view_model.dart';

class ResourceListPage extends StatelessWidget {
  final ResourceType type;
  final String categoryId;

  ResourceListPage({@required this.type, @required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ResourceListViewModel>(
      onInit: (store) {
        store.dispatch(FetchCategoryAction(categoryId));
        store
            .dispatch(FetchResourcesAction(type: type, categoryId: categoryId));
      },
      distinct: true,
      converter: (store) => ResourceListViewModel.fromStore(store, type),
      builder: (_, viewModel) => ResourceListPageContent(viewModel, categoryId),
    );
  }
}

class ResourceListPageContent extends StatelessWidget {
  final ResourceListViewModel viewModel;
  final String categoryId;

  ResourceListPageContent(this.viewModel, this.categoryId);

  @override
  Widget build(BuildContext context) {
    String title = viewModel.category?.name ?? 'Cargando...';
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          ImageAppBar(
            heroTag: viewModel.category?.id ?? 'placeholder',
            label: title,
            imageUrl: viewModel.category?.imageUrl ?? '',
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SectionTitle(label: 'Popular'),
                _buildFeaturedList(),
                SectionTitle(label: 'Todos'),
                _buildResourcesList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedList() {
    return LoadingView(
      status: viewModel.resourcesLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Hubo un problema cargando el recurso.',
        onRetry: () => viewModel.refreshResources(viewModel.type, categoryId),
      ),
      successContent: ResourceHorizontalList(
        resources: viewModel.resources,
        onReloadCallback: () =>
            viewModel.refreshResources(viewModel.type, categoryId),
        onItemSelected: (LResource resource) =>
            viewModel.resourceSelected(resource.id),
      ),
    );
  }

  Widget _buildResourcesList() {
    return LoadingView(
      status: viewModel.resourcesLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Hubo un problema cargando el recurso.',
        onRetry: () => viewModel.refreshResources(viewModel.type, categoryId),
      ),
      successContent: ResourceHorizontalList(
        resources: viewModel.resources,
        onReloadCallback: () =>
            viewModel.refreshResources(viewModel.type, categoryId),
        onItemSelected: (LResource resource) =>
            viewModel.resourceSelected(resource.id),
      ),
    );
  }
}
