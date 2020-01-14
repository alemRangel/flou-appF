import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class SocialIconButton extends StatelessWidget {
  final Color leftColor = Colors.black;
  final Color rightColor = Colors.white;

  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  SocialIconButton({
    @required this.label,
    @required this.color,
    @required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 8.0),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: color,
                onPressed: () => {},
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: onPressed,
                          padding: EdgeInsets.only(
                            top: 20.0,
                            bottom: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                icon,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              Text(
                                label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
