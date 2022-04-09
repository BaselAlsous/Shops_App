part of 'regester_cubit.dart';

@immutable
abstract class RegesterState {}

class RegesterInitial extends RegesterState {}

class WatchPasswordStatus extends RegesterState {}

class UserRegesterLoadingStatus extends RegesterState {}

class UserRegesterSuccessStatus extends RegesterState {
  final RegesterModel regesterModel;

  UserRegesterSuccessStatus({required this.regesterModel});
}

class UserRegesterErrorStatus extends RegesterState {
  final String error;

  UserRegesterErrorStatus(this.error);
}