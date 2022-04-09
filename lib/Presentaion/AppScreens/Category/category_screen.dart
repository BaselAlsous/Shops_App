import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/Buisness/AppCubit/shop_app_cubit.dart';
import 'package:test/Presentaion/AppScreens/Category/Components/custom_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoryModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cubit.categoryModel?.data?.itemData?.length,
              itemBuilder: (context, index) {
                var categores = cubit.categoryModel?.data?.itemData?[index];
                return CustomeCard(
                  image: categores?.image ??
                      "https://thumbs.dreamstime.com/b/african-american-businesswoman-architect-real-estate-sales-person-full-wide-banner-beautiful-african-american-business-person-164732738.jpg",
                  title: categores?.name ?? "Error",
                );
              },
            );
          },
        );
      },
    );
  }
}
