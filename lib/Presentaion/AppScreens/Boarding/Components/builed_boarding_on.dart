import 'package:flutter/material.dart';
import 'package:test/Presentaion/AppScreens/Boarding/Model/boarding_model.dart';

Widget builedBoardingOn({
  required BoardingModel data,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image: AssetImage(data.img)),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        data.header,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        data.body,
        style: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
    ],
  );
}
