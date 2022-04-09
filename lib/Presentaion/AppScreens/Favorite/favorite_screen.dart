import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/Buisness/AppCubit/shop_app_cubit.dart';
import 'package:test/Presentaion/AppScreens/Favorite/Components/custom_favorite_grid_tile.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetDataFavoriteLoadingStatus,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            var favoriteProdect = cubit.favoriteModel?.data?.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1 / 1.3,
                ),
                itemCount: favoriteProdect?.length,
                itemBuilder: (context, index) {
                  return CustomFavoriteGridTile(
                    model: favoriteProdect?[index],
                    color: cubit.favorite[favoriteProdect?[index].product?.id!]!
                        ? Colors.red
                        : Colors.grey,
                    onPressed: () {
                      cubit.changeFavoriteData(
                          productId: favoriteProdect?[index].product?.id);
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
