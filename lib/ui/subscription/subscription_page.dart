import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/config.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/field_dialog/field_dialog_page.dart';
import 'package:learning/ui/subscription/subscription_view_model.dart';
import 'dart:io' show Platform;

class SubscriptionPage extends StatelessWidget {
  final String navigateTo;

  SubscriptionPage(this.navigateTo);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SubscriptionPageViewModel>(
      onInit: (store) => SubscriptionPageViewModel.onInit(store, navigateTo),
      distinct: true,
      converter: (store) => SubscriptionPageViewModel.fromStore(store),
      builder: (_, viewModel) => SubscriptionPageContent(viewModel),
    );
  }
}

class SubscriptionPageContent extends StatelessWidget {
  final SubscriptionPageViewModel viewModel;

  SubscriptionPageContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: _buildContent(context),
    );
  }

  Widget _buildWhileLoading(BuildContext context) {
    return LoadingView(
      status: viewModel.loadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
          description: 'Hubo un problema cargando la suscripción.',
          onRetry: viewModel.refreshSubscription
      ),
      successContent: _buildActions(context),
    );
  }


  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildHeaderImage(context),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 42.0, horizontal: 24.0),
            child: _buildPromoText(context),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: _buildFeatures(context),
          ),
         _buildWhileLoading(context),
        ],
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/subscription_bg.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200.0,
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
          'Únete a Flou Academy',
          style: textTheme.display1
              .copyWith(color: Colors.black87, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.0),
        Text(
          'Obtén acceso ilimitado a nuestros cursos de expertos, meditaciones y libros para transformar cada área de tu vida.',
          style: textTheme.display1
              .copyWith(color: Colors.grey[800], fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 4.0),
      child: Column(
        children: <Widget>[
          Text(
            'Que Recibirás',
            style: textTheme.display1
                .copyWith(color: Colors.grey[800], fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          _buildFeature(
              'Cursos en Video: Acceso ilimitado a nuestra librería de cursos en video de mentores y expertos en todas las áreas de la vida.'),
          SizedBox(height: 6.0),
          _buildFeature(
              'Meditaciones: Acceso ilimitado a nuestra librería de meditaciones diarias que te ayudarán a impulsar tu transformación, vivir en el presente, mejorar tu salud, sanar tu pasado y visualizar tu futuro.'),
          SizedBox(height: 6.0),
          _buildFeature(
              'Libros: Recomendaciones de los mejores libros para transformar tu vida.'),
        ],
      ),
    );
  }

  Widget _buildFeature(String content) {
    return ListTile(
      leading: Icon(
        Icons.check_circle,
        size: 32.0,
        color: Colors.blueAccent,
      ),
      title: Text(
        content,
        style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
      ),
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

  Widget _buildActions(BuildContext context) {
    if (viewModel.subscription == null) return Container();

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 12.0),
            child: _buildFooter(context),
          ),
          _buildBuyButton(context),
          _buildCodeButton(context),
        ],
      ),
    );
  }

  Widget _buildBuyButton(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialButton(
      minWidth: width,
      onPressed: () => viewModel.subscribe(viewModel.subscription.productId),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Probar Gratis por 7 días',
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.0),
          Text(
            _priceLabel(double.parse(viewModel.subscription.price)),
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      color: Theme.of(context).primaryColor,
      elevation: 0.0,
    );
  }

  String _priceLabel(double price) {
    if (Platform.isIOS) {
      return 'después \$${price.toStringAsFixed(0)}, cobrado anualmente';
    } else {
      double monthPrice = price / 12.0;
      return 'después \$${monthPrice.toStringAsFixed(0)} mensuales, cobrado anualmente';
    }
  }

  Widget _buildFooter(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    if (Platform.isIOS) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(_iosFooterMessage(double.parse(viewModel.subscription.price)),
            style: textTheme.display1
                .copyWith(color: Colors.grey[800], fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 14.0),
          OutlineButton(
            onPressed: () => viewModel.navigateToUrl('https://firebasestorage.googleapis.com/v0/b/flou-academy.appspot.com/o/static%2FTerminos%20y%20condiciones%20Flou%20Academy.pdf?alt=media&token=8ebfedcf-f750-4baf-bccb-e0d1e24a490c'),
            child: Text('Términos'),
          ),
          OutlineButton(
            onPressed: () => viewModel.navigateToUrl('https://firebasestorage.googleapis.com/v0/b/flou-academy.appspot.com/o/static%2FPol%C3%ADtica%20de%20Privacidad%20Flou%20Academy.pdf?alt=media&token=5ae9e3c6-be37-4288-92a5-6b20be7c240c'),
            child: Text('Privacidad'),
          ),
        ],
      );
    } else {
      return Text(
        'Recibirás acceso a contenido exclusivo de clase mundial para ayudarte a transformar tu vida.',
        style: textTheme.display1
            .copyWith(color: Colors.grey[800], fontSize: 16.0),
        textAlign: TextAlign.center,
      );
    }
  }

  String _iosFooterMessage(double price) {
    return 'Términos de suscripción: se iniciará su suscripción anual ' +
        'y se le cobrarán \$${price.toStringAsFixed(0)}. ' +
        'La suscripción se renueva automáticamente a menos que esté ' +
        'desactivada en la configuración de la cuenta al menos 24 ' +
        'horas antes de que finalice el período actual. El pago se carga ' +
        'a su cuenta de iTunes. La porción no utilizada de la prueba gratuita se ' +
        'pierde después de la compra.';
  }


  Widget _buildCodeButton(BuildContext context) {
    if (Platform.isIOS) return Container();

    return SizedBox(
      height: 32.0,
      child: FlatButton(
        color: Colors.transparent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<DismissDialogAction>(
              builder: (BuildContext context) {
                return FullScreenDialogPage(
                  title: 'Redime tu código',
                  label: 'Código de activación',
                  actionLabel: 'CONTINUAR',
                  onValueSubmitted: (String code) =>
                      viewModel.useActivationCode(code),
                );
              },
              fullscreenDialog: true,
            ),
          );
        },
        child: Text(
          'Tengo un código de referido',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.all(4.0),
      ),
    );
  }
}
