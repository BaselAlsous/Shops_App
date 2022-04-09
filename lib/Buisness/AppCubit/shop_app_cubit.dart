// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/Data/Api/dio_helper.dart';
import 'package:test/Data/LocalStorage/Cache_helper.dart';
import 'package:test/Data/Model/category_model.dart';
import 'package:test/Data/Model/change_favorite_model.dart';
import 'package:test/Data/Model/favorite_model.dart';
import 'package:test/Data/Model/home_model.dart';
import 'package:test/Data/Model/profile_model.dart';
import 'package:test/Data/Model/upadate_profile_model.dart';
import 'package:test/Presentaion/Constent/EndPoint/end_point.dart';
import 'package:test/Presentaion/AppScreens/Category/category_screen.dart';
import 'package:test/Presentaion/AppScreens/Favorite/favorite_screen.dart';
import 'package:test/Presentaion/AppScreens/Home/home_screen.dart';
import 'package:test/Presentaion/AppScreens/Settings/settings_screen.dart';

part 'shop_app_state.dart';

class ShopAppCubit extends Cubit<ShopState> {
  ShopAppCubit() : super(ShopInitial());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  // todo:  Function To CONVERTE Theme
  bool isDark = false;

  void convertTheme({bool? shaerdTheme}) {
    if (shaerdTheme != null) {
      isDark = shaerdTheme;
      emit(ConverteThemeStatus());
    } else {
      isDark = !isDark;
      CacheHelper.setData(key: 'isDark', value: isDark).then((value) {
        emit(ConverteThemeStatus());
      });
    }
  }

  // todo: Function To Toggle Bottom Nav Bar
  int currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];

  void toggleBottomNavBar(int index) {
    currentIndex = index;
    if (currentIndex == 0) {
      getHomeData();
    } else if (currentIndex == 1) {
      getCategoryData();
    } else if (currentIndex == 2) {
      getAllFavoriteProduct();
    } else if (currentIndex == 3) {
      print(EndPoint.token);
      getProfileData();
    }
    emit(ToggleBottomNavbarStatus());
  }

  // todo: Function To Get All Data Home Screen
  HomeModel? homeModel;
  Map<int?, bool?> favorite = {};

  void getHomeData() {
    DioHelper.getAllData(
      url: EndPoint.methodHome,
      token: EndPoint.token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value!.data);

      homeModel?.data?.products?.forEach((element) {
        favorite.addAll({
          element.id: element.inFavorites,
        });
      });

      emit(GetDataHomeSuccessStatus());
    }).catchError((error) {
      emit(GetDataHomeErrorStatus());
      print(error.toString());
    });
  }

  // todo: Function To Change Favorite Screen
  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavoriteData({
    required int? productId,
  }) {
    favorite[productId] = !favorite[productId]!;
    emit(ChangeFacoriteSuccessStatus());
    DioHelper.postData(
      url: EndPoint.methodChangeFavorite,
      token: EndPoint.token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value!.data);
      if (changeFavoriteModel?.status == false) {
        favorite[productId] = !favorite[productId]!;
      } else {
        getAllFavoriteProduct();
      }
      emit(ChangeFacoriteSuccessStatus());
    }).catchError((error) {
      emit(ChangeFacoriteErrorStatus());
    });
  }

  // todo: Function To Get All Favorite Screen
  FavoriteModel? favoriteModel;
  void getAllFavoriteProduct() {
    emit(GetDataFavoriteLoadingStatus());
    DioHelper.getAllData(
      url: 'favorites',
      token: EndPoint.token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value!.data);
      emit(GetDataFavoriteSuccessStatus());
    }).catchError((error) {
      emit(GetDataFavoriteErrorStatus());
      print('get favorite Error' + error);
    });
  }

  // todo: Function To Get All Data Category Screen
  CategoryModel? categoryModel;

  void getCategoryData() {
    DioHelper.getAllData(
      url: EndPoint.methodCategory,
      token: EndPoint.token,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value!.data);
      emit(GetDataCategorySuccessStatus());
    }).catchError((error) {
      emit(GetDataCategoryErrorStatus());
      print(error.toString());
    });
  }

  // todo: Function To Get All Data Profile Screen
  ProfileModel? profileModel;

  void getProfileData() {
    DioHelper.getAllData(
      url: EndPoint.methodProfile,
      token: EndPoint.token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value!.data);
      emit(GetDataProfileSuccessStatus(profileModel: profileModel));
    }).catchError((error) {
      emit(GetDataProfileErrorStatus());
      print(error.toString());
    });
  }

  // todo: Function To Get All Data Update Profile Screen
  UpdateProfileModel? updateprofileModel;

  void updateProfileData({
    required String name,
    required String email,
    required String phone,
  }) {
    DioHelper.putData(
      url: EndPoint.methodUpdateProfile,
      token: EndPoint.token,
      data: {
        'name': name,
        "email": email,
        "phone": phone,
      },
    ).then((value) {
      updateprofileModel = UpdateProfileModel.fromJson(value!.data);
      emit(GetDataUpdateProfileSuccessStatus(
          updateprofileModel: updateprofileModel));
    }).catchError((error) {
      emit(GetDataUpdateProfileErrorStatus());
      print(error.toString());
    });
  }
}
