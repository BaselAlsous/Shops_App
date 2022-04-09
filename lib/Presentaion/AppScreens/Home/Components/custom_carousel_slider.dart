import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test/Data/Model/home_model.dart';

class CustomCarouselSlider extends StatelessWidget {
  final HomeModel? model;
  const CustomCarouselSlider({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      height: 200.0,
      child: CarouselSlider(
        items: model?.data?.banners
            ?.map(
              (e) => Image(
                image: NetworkImage(e.image),
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 250.0,
          initialPage: 0,
          viewportFraction: 1.0,
          reverse: false,
          autoPlay: true,
          enableInfiniteScroll: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          scrollDirection: Axis.horizontal,
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }
}
