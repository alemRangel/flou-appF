import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

import 'social_icon_button.dart';

class SocialAuth extends StatelessWidget {
  final Function onSignInWithProvider;

  SocialAuth({@required this.onSignInWithProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.25)),
                ),
              ),
              Text(
                'Ó CONÉCTATE CON',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.25)),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
          child: Row(
            children: <Widget>[
              SocialIconButton(
                label: 'FACEBOOK',
                color: Color(0Xff3B5998),
                icon: FontAwesomeIcons.facebook,
                onPressed: () => onSignInWithProvider(SignInProvider.facebook),
              ),
              SocialIconButton(
                label: 'GOOGLE',
                color: Color(0Xffdb3236),
                icon: FontAwesomeIcons.google,
                onPressed: () => onSignInWithProvider(SignInProvider.google),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
