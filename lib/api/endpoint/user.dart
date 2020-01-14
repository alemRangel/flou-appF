import 'package:learning/api/endpoint/base.dart';
import 'package:learning/api/mapper/user.dart';
import 'package:learning/data/data.dart';

class UserEndpoint extends Base<User> {
  UserEndpoint() : super('users', UserMapper());
}
