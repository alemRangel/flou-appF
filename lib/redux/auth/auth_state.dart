import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

@immutable
class AuthState {
  final User user;
  final LoadingStatus signInStatus;

  AuthState({
    @required this.user,
    @required this.signInStatus,
  });

  factory AuthState.initial() {
    return AuthState(
      user: null,
      signInStatus: LoadingStatus.idle,
    );
  }

  AuthState copyWith({
    User user,
    LoadingStatus signInStatus,
  }) {
    return AuthState(
      user: user ?? this.user,
      signInStatus: signInStatus ?? this.signInStatus,
    );
  }

  @override
  int get hashCode => user.hashCode ^ signInStatus.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthState &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          signInStatus == other.signInStatus;

  @override
  String toString() {
    return 'AuthState{chapter: $user, chapterLoadingStatus: $signInStatus}';
  }
}
