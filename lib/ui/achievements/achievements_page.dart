import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/explore/tab/explore_tab_view_model.dart';

typedef Widget BuildContent();

class AchievementsPage<T extends ResourceType> extends StatelessWidget {
  final T type;

  AchievementsPage({this.type});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExploreTabViewModel>(
      distinct: true,
      converter: (store) => ExploreTabViewModel.fromStore<T>(store, type),
      builder: (_, viewModel) => AchievementsPageContent(viewModel),
    );
  }
}

class AchievementsPageContent extends StatelessWidget{
  //final AchievementsPageViewModel viewModel;
  final ExploreTabViewModel viewModel;


  AchievementsPageContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Achievements',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          _buildFeaturedList(),
        ],
      ),
    );
  }


  Widget _buildOption(String title, IconData icon, Function onTab){
    return ListTile(
      onTap: onTab,
      leading: Icon(
        icon,
        color: Colors.grey,
      ),
      title: Text(title),
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
}
