import 'package:meta/meta.dart';

class User {
  final String uid;
  final String displayName;
  final String email;
  final bool isEmailVerified;
  final String phoneNumber;
  final String photoUrl;
  final String referralCode;
  final bool hasActiveSubscription;

  const User({
    @required this.uid,
    @required this.displayName,
    @required this.email,
    @required this.isEmailVerified,
    @required this.phoneNumber,
    @required this.photoUrl,
    @required this.referralCode,
    @required this.hasActiveSubscription,
  });

  User copyWith({bool hasActiveSubscription,}) {
    return User(
      uid: this.uid,
      displayName: this.displayName,
      email: this.email,
      isEmailVerified: this.isEmailVerified,
      phoneNumber: this.phoneNumber,
      photoUrl: this.photoUrl,
      referralCode: this.referralCode,
      hasActiveSubscription:
          hasActiveSubscription ?? this.hasActiveSubscription,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      isEmailVerified: json['isEmailVerified'],
      phoneNumber: json['phoneNumber'],
      photoUrl: json['photoUrl'],
      referralCode: json['referralCode'],
      hasActiveSubscription: json['hasActiveSubscription'],
    );
  }
}
