// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:test/Data/Api/dio_helper.dart';
import 'package:test/Data/LocalStorage/Cache_helper.dart';
import 'package:test/Presentaion/Constent/EndPoint/end_point.dart';
import 'package:test/Presentaion/Constent/Theme/app_theme.dart';
import 'package:test/Presentaion/AppScreens/Boarding/boarding_screen.dart';
import 'package:test/Presentaion/AppScreens/Login/Screens/login_screen.dart';
import 'package:test/Presentaion/shop_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget widget;

  EndPoint.token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    widget = const LoginScreen();
    if (EndPoint.token != 'null') {
      widget = const ShopLayout();
    }
  } else {
    widget = const BoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: startWidget,
    );
  }
}
