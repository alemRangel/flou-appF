import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/spotlight/spotlight_actions.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/spotlight/spotlight_view_model.dart';
import 'package:learning/ui/spotlight/widget/spotlight_list.dart';

class SpotlightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SpotlightPageViewModel>(
      onInit: (store) => store.dispatch(FetchSpotlightsAction()),
      distinct: true,
      converter: (store) => SpotlightPageViewModel.fromStore(store),
      builder: (_, viewModel) => SpotlightPageContent(viewModel),
    );
  }
}

class SpotlightPageContent extends StatelessWidget {
  final SpotlightPageViewModel viewModel;

  SpotlightPageContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotlight'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildSocialButtons(),
        Expanded(
          child: _buildSpotlights(),
        ),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'social:facebook',
            backgroundColor: const Color(0xFF0084ff),
            elevation: 2.0,
            child: const Icon(
              FontAwesomeIcons.facebook,
              color: Colors.white,
            ),
            onPressed: () => viewModel.navigateTo('https://www.facebook.com/flouacademy/'),
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            heroTag: 'social:instagram',
            backgroundColor: const Color(0xFFd62976),
            elevation: 2.0,
            child: const Icon(
              FontAwesomeIcons.instagram,
              color: Colors.white,
            ),
            onPressed: () => viewModel.navigateTo('https://www.instagram.com/flouacademy/'),
          ),
        ],
      ),
    );
  }

  Widget _buildSpotlights() {
    return LoadingView(
      status: viewModel.status,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Hubo un problema cargando las noticias.',
        onRetry: viewModel.refreshSpotlights,
      ),
      successContent: SpotlightList(
        spotlights: viewModel.spotlights,
        onItemSelected: (Spotlight spotlight) =>
            viewModel.navigateTo(spotlight.actionUrl),
      ),
    );
  }
}
