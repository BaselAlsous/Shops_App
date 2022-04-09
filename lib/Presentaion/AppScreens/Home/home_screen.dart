import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/Buisness/AppCubit/shop_app_cubit.dart';
import 'package:test/Data/Model/home_model.dart';
import 'package:test/Presentaion/AppScreens/Home/Components/custom_carousel_slider.dart';
import 'package:test/Presentaion/AppScreens/Home/Components/custom_grid_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoryModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            List<Products>? product = cubit.homeModel?.data?.products;
            var category = cubit.categoryModel?.data?.itemData;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carousel Slider
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCarouselSlider(
                        model: cubit.homeModel,
                      ),
                    ],
                  ),
                  // Categories
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      left: 10.0,
                      right: 10.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100.0,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 3.0,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: category?.length,
                        itemBuilder: (context, index) {
                          return GridTile(
                            footer: Container(
                              width: double.infinity,
                              color: Colors.black.withOpacity(0.5),
                              child: Text(
                                category?[index].name ?? "",
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            child: SizedBox(
                              child: Image(
                                image:
                                    NetworkImage(category?[index].image ?? ""),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Products
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      left: 10.0,
                      right: 10.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      'New Products',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1 / 1.3,
                    ),
                    itemCount: product?.length,
                    itemBuilder: (context, index) {
                      return CustomGridTile(
                        product: product?[index],
                        color: cubit.favorite[product?[index].id]!
                            ? Colors.red
                            : Colors.grey,
                        onPressed: () {
                          cubit.changeFavoriteData(
                              productId: product?[index].id);
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
