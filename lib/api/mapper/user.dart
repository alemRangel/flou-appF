import 'package:learning/api/mapper/mapper.dart';
import 'package:learning/data/data.dart';

class UserMapper extends Mapper<User> {
  @override
  User transformData(dynamic data) {
    return User(
      uid: data['uid'],
      displayName: data['displayName'],
      email: data['email'],
      isEmailVerified: data['isEmailVerified'],
      phoneNumber: data['phoneNumber'],
      photoUrl: data['photoUrl'],
      referralCode: data['referralCode'],
      hasActiveSubscription: data['hasActiveSubscription'] ?? false,
    );
  }
  @override
  User transformTest(dynamic json) {
    return User.fromJson(json);
  }
}
