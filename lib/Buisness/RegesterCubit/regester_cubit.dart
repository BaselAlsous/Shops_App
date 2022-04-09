import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:test/Data/Api/dio_helper.dart';
import 'package:test/Data/Model/LoginModel/regester_model.dart';

part 'regester_state.dart';

class RegesterCubit extends Cubit<RegesterState> {
  RegesterCubit() : super(RegesterInitial());

  static RegesterCubit get(context) => BlocProvider.of(context);

  // todo: Change Status Password To see
  bool obscureText = true;

  void changeStatusPassword() {
    obscureText = !obscureText;
    emit(WatchPasswordStatus());
  }

  // todo: User Regester

  late RegesterModel regesterModel;

  void userRegester({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(UserRegesterLoadingStatus());
    DioHelper.postData(url: 'register', data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      regesterModel = RegesterModel.fromJson(value?.data);
      emit(UserRegesterSuccessStatus(regesterModel: regesterModel));
    }).catchError((error) {
      emit(UserRegesterErrorStatus(error.toString()));
    });
  }
}
