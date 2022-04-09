// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:test/Buisness/RegesterCubit/regester_cubit.dart';
import 'package:test/Data/LocalStorage/Cache_helper.dart';
import 'package:test/Presentaion/Constent/EndPoint/end_point.dart';
import 'package:test/Presentaion/Constent/Method/navigation.dart';
import 'package:test/Presentaion/AppScreens/Login/Components/custom_text_fome_field.dart';
import 'package:test/Presentaion/AppScreens/Login/Screens/login_screen.dart';
import 'package:test/Presentaion/Widget/custom_button.dart';
import 'package:test/Presentaion/Widget/custom_toast.dart';
import 'package:test/Presentaion/shop_layout.dart';


class RegesterScreen extends StatelessWidget {
  const RegesterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? emailEditingController = TextEditingController();
    TextEditingController? passwordEditingController = TextEditingController();
    TextEditingController? nameEditingController = TextEditingController();
    TextEditingController? phoneEditingController = TextEditingController();
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => RegesterCubit(),
      child: BlocConsumer<RegesterCubit, RegesterState>(
        listener: (context, state) {
          if (state is UserRegesterSuccessStatus) {
            if (state.regesterModel.status) {
              customToast(
                msg: state.regesterModel.message,
                backgroundColor: Colors.green,
              );
              CacheHelper.setData(
                      key: 'token', value: state.regesterModel.data?.token)
                  .then((value) {
                print('Create Token');
                EndPoint.token = CacheHelper.getData(key: 'token');
                Navigation.navigationAndNotBack(
                  context: context,
                  page: const ShopLayout(),
                );
              });
            } else {
              customToast(
                msg: state.regesterModel.message,
                backgroundColor: Colors.red,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = RegesterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  // Title Page (Regester)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                    child: Text(
                      'Regester',
                      style: TextStyle(
                        color: Color.fromARGB(255, 73, 70, 70),
                        fontSize: 50.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Form(
                    key: keyForm,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // Text Form Field To Email
                          CustomeTextFormField(
                            textEditingController: emailEditingController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'Email',
                            prefixIcon: Icons.email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          // Text Form Field To Name
                          CustomeTextFormField(
                            textEditingController: nameEditingController,
                            keyboardType: TextInputType.text,
                            labelText: 'Name',
                            prefixIcon: Icons.person,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          // Text Form Field To Phone
                          CustomeTextFormField(
                            textEditingController: phoneEditingController,
                            keyboardType: TextInputType.phone,
                            labelText: 'Phone +962 0.....',
                            prefixIcon: Icons.email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Phone';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          // Text Form Field To Password
                          CustomeTextFormField(
                            textEditingController: passwordEditingController,
                            keyboardType: TextInputType.visiblePassword,
                            labelText: 'Password',
                            prefixIcon: Icons.lock,
                            suffixIcon: cubit.obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onPressed: () {
                              cubit.changeStatusPassword();
                            },
                            obscureText: cubit.obscureText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          // Login Button
                          ConditionalBuilder(
                            condition: state is! UserRegesterLoadingStatus,
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                            builder: (context) => CustomButton(
                              title: 'Regester',
                              onPressed: () {
                                if (keyForm.currentState!.validate()) {
                                  cubit.userRegester(
                                    name: nameEditingController.text,
                                    email: emailEditingController.text,
                                    password: passwordEditingController.text,
                                    phone: phoneEditingController.text,
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          // If You Don't Have Account
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("If you have any account"),
                              TextButton(
                                onPressed: () {
                                  Navigation.navigationAndNotBack(
                                      context: context,
                                      page: const LoginScreen());
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
