import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/ui/settings/settings_view_model.dart';
import 'dart:io' show Platform;

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsPageViewModel>(
      distinct: true,
      converter: (store) => SettingsPageViewModel.fromStore(store),
      builder: (_, viewModel) => SettingsPageContent(viewModel),
    );
  }
}

class SettingsPageContent extends StatelessWidget {
  final SettingsPageViewModel viewModel;

  SettingsPageContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuenta'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Configuración de cuenta',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 2.0,
            child: Column(
              children: <Widget>[
                _buildReferral(),
                _buildOption(
                  'Cerrar sesión',
                  Icons.exit_to_app,
                  () => viewModel.logout(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferral() {
    if (Platform.isIOS) return Container();
    return _buildOption(
      'Gana un mes gratis',
      Icons.money_off,
          () => viewModel.navigateToReferral(),
    );
  }

  Widget _buildOption(String title, IconData icon, Function onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.grey,
      ),
      title: Text(title),
      trailing: Icon(Icons.arrow_right),
    );
  }
}
