import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learning/api/api.dart';
import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

class AuthCancelledException implements Exception {
  final String message;

  AuthCancelledException(this.message);

  @override
  String toString() => message;
}

class Auth {
  final FirebaseAuth firebaseAuth;
  final UserEndpoint userEndpoint;

  Auth({@required this.userEndpoint, @required this.firebaseAuth});

  Future<User> getCurrentUser() async {
    FirebaseUser user = await firebaseAuth.currentUser().timeout(
        Duration(seconds: 15),
        onTimeout: () => Future.error(Exception(
            'Unable to get your user data. Please check your network connection.')));
    return _fetchFromFirebase(user);
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw AuthCancelledException('User cancelled');
    }

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser user = await firebaseAuth.signInWithCredential(credential);

    if (user == null) {
      throw Exception('Unable to sign-in with Google');
    }

    return _fetchFromFirebase(user);
  }

  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(['email']);

    // ignore: missing_enum_constant_in_switch
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        throw AuthCancelledException('User cancelled');
      case FacebookLoginStatus.error:
        throw Exception('Error occurred: ${result.errorMessage}');
    }

    if (result.status != FacebookLoginStatus.loggedIn) {
      throw Exception('Unknown status: ${result.status}');
    }

    AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token,
    );

    FirebaseUser user = await firebaseAuth.signInWithCredential(credential);

    return await _fetchFromFirebase(user);
  }

  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return await _fetchFromFirebase(user);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return await _fetchFromFirebase(user);
  }

  Future<User> _fetchFromFirebase(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) return null;
    User dbUser;
    try {
      dbUser = await userEndpoint.get(firebaseUser.uid);
     // dbUser = await userEndpoint.getTest("uId1");
    } catch (e) {
      print(e);
    }

    if (dbUser == null) {
      return User(
        uid: firebaseUser.uid,
        phoneNumber: firebaseUser.phoneNumber,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
        isEmailVerified: firebaseUser.isEmailVerified,
        photoUrl: firebaseUser.photoUrl,
        referralCode: 'Cargando...',
        hasActiveSubscription: false,
      );
    } else {
      return dbUser;
    }
  }
}
