import 'package:flutter/material.dart';

class RequestPermission extends StatelessWidget {
  final VoidCallback onAskPermission;

  RequestPermission(this.onAskPermission);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Please grant accessing storage permission to continue -_-',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            FlatButton(
              onPressed: onAskPermission,
              child: Text(
                'Retry',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
