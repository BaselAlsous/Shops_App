// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/Buisness/AppCubit/shop_app_cubit.dart';
import 'package:test/Data/LocalStorage/Cache_helper.dart';
import 'package:test/Presentaion/Constent/EndPoint/end_point.dart';
import 'package:test/Presentaion/Constent/Method/navigation.dart';
import 'package:test/Presentaion/AppScreens/Login/Components/custom_text_fome_field.dart';
import 'package:test/Presentaion/AppScreens/Login/Screens/login_screen.dart';
import 'package:test/Presentaion/Widget/custom_button.dart';
import 'package:test/Presentaion/Widget/custom_toast.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? nameTextEditingController = TextEditingController();
    TextEditingController? emailTextEditingController = TextEditingController();
    TextEditingController? phoneTextEditingController = TextEditingController();

    return BlocConsumer<ShopAppCubit, ShopState>(
      listener: (context, state) {
        if (state is GetDataProfileSuccessStatus) {
          nameTextEditingController.text =
              state.profileModel?.users?.name ?? "Error";
          emailTextEditingController.text =
              state.profileModel?.users?.email ?? "Error";
          phoneTextEditingController.text =
              state.profileModel?.users?.phone ?? "Error";
        }
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.profileModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomeTextFormField(
                      textEditingController: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      labelText: nameTextEditingController.text,
                      prefixIcon: Icons.person,
                      validator: (e) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomeTextFormField(
                      textEditingController: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      labelText: emailTextEditingController.text,
                      prefixIcon: Icons.email,
                      validator: (e) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomeTextFormField(
                      textEditingController: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      labelText: phoneTextEditingController.text,
                      prefixIcon: Icons.phone,
                      validator: (e) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    CustomButton(
                        onPressed: () {
                          cubit.updateProfileData(
                            name: nameTextEditingController.text,
                            email: emailTextEditingController.text,
                            phone: phoneTextEditingController.text,
                          );
                          customToast(
                              msg: 'Updated Complete',
                              backgroundColor: Colors.green);
                        },
                        title: 'Update'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    CustomButton(
                        onPressed: () {
                          CacheHelper.setData(key: 'token', value: 'null')
                              .then((value) {
                            print('Delete Token');
                            EndPoint.token = CacheHelper.getData(key: 'token');
                            print(EndPoint.token);
                            Navigation.navigationAndNotBack(
                                context: context, page: const LoginScreen());
                          });
                        },
                        title: 'loguot'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
