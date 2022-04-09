// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:test/Data/Api/dio_helper.dart';
import 'package:test/Data/Model/LoginModel/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  // todo: Change Status Password To see
  bool obscureText = true;

  void changeStatusPassword() {
    obscureText = !obscureText;
    emit(WatchPasswordStatus());
  }

  // todo: User Login

  late LoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(UserLoginLoadingStatus());
    DioHelper.postData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value?.data);
      emit(UserLoginSuccessStatus(loginModel));
    }).catchError((error) {
      emit(UserLoginErrorStatus(error.toString()));
    });
  }
}
