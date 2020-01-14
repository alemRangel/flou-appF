import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/search/search_view_model.dart';

class SearchPage extends SearchDelegate<LResource> {
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    return StoreConnector<AppState, SearchPageViewModel>(
      distinct: true,
      converter: (store) => SearchPageViewModel.fromStore(store),
      builder: (_, viewModel) => SearchResults(viewModel, query),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            ),
    ];
  }
}

class SearchResults extends StatelessWidget {
  final SearchPageViewModel viewModel;
  final String query;

  SearchResults(this.viewModel, this.query);

  @override
  Widget build(BuildContext context) {
    viewModel.search(query);
    return LoadingView(
      status: viewModel.searchLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Hubo un problema cargando las noticias.',
        onRetry: null,
      ),
      successContent: ResourceList(
        resources: viewModel.searchResult?.hits ?? [],
        onReloadCallback: null,
        onItemSelected: (LResource resource) =>
            viewModel.resourceSelected(resource.id),
      ),
    );
  }
}
