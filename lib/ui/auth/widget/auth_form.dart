import 'package:flutter/material.dart';

import 'custom_form_field.dart';

class AuthForm extends StatefulWidget {
  final String actionLabel;
  final String extraActionLabel;
  final Function onActionPressed;
  final Function onExtraActionPressed;

  AuthForm({
    @required this.actionLabel,
    @required this.onActionPressed,
    @required this.extraActionLabel,
    @required this.onExtraActionPressed,
  });

  @override
  State createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomFormField(
          label: 'EMAIL',
          hintText: 'email@ejemplo.com',
          controller: emailController,
        ),
        Divider(height: 24.0),
        CustomFormField(
          label: 'CONTRASEÑA',
          hintText: '********',
          obscureText: true,
          controller: passwordController,
        ),
        Divider(height: 24.0),
        _buildExtraAction(context),
        Divider(height: 24.0),
        _buildActionButton(context),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Theme.of(context).accentColor,
              onPressed: _actionPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Text(
                  widget.actionLabel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtraAction(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: new FlatButton(
            child: new Text(
              widget.extraActionLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.end,
            ),
            onPressed: widget.onExtraActionPressed,
          ),
        ),
      ],
    );
  }

  void _actionPressed() {
    if (widget.onActionPressed != null) {
      widget.onActionPressed(
          emailController.value.text, passwordController.value.text);
    }
  }
}
