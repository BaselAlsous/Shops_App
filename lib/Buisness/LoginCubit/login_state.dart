part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class WatchPasswordStatus extends LoginState {}

class UserLoginLoadingStatus extends LoginState {}

class UserLoginSuccessStatus extends LoginState {
  final LoginModel loginModel;

  UserLoginSuccessStatus(this.loginModel);
}

class UserLoginErrorStatus extends LoginState {
  final String error;

  UserLoginErrorStatus(this.error);
}
