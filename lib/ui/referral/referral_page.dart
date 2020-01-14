import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/config.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/ui/referral/referral_view_model.dart';

class ReferralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ReferralPageViewModel>(
      distinct: true,
      converter: (store) => ReferralPageViewModel.fromStore(store),
      builder: (_, viewModel) => ReferralPageContent(viewModel),
    );
  }
}

class ReferralPageContent extends StatelessWidget {
  final ReferralPageViewModel viewModel;

  ReferralPageContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildHeaderImage(context),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 42.0, horizontal: 24.0),
          child: _buildPromoText(context),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: _buildShareButton(context),
        ),
      ],
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/subscription_bg.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300.0,
        ),
        _buildBackButton(context),
      ],
    );
  }

  Widget _buildPromoText(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        Text(
          'Gana 1 mes gratis',
          style: textTheme.display1
              .copyWith(color: Colors.black87, fontSize: 24.0),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 14.0),
        Text(
          'Comparte este código con tus amigos para que ellos y tu ganen 1 mes gratis.',
          style: textTheme.display1
              .copyWith(color: Colors.grey[800], fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 4.0,
      right: 8.0,
      child: Material(
        type: MaterialType.circle,
        color: Colors.white70,
        child: IconButton(
          icon: Icon(Icons.close),
          iconSize: 24.0,
          color: Colors.black87,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  Widget _buildShareButton(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 20.0),
              child: Text(
                'Tu código: ${viewModel.referralCode}',
                style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton.icon(
                  label: const Text('Copiar'),
                  icon: const Icon(Icons.content_copy),
                  color: Colors.grey[200],
                  onPressed: viewModel.copyToClipboard,
                ),
                RaisedButton.icon(
                  label: const Text('Compartir'),
                  icon: const Icon(Icons.share),
                  color: Colors.grey[200],
                  onPressed: viewModel.share,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
