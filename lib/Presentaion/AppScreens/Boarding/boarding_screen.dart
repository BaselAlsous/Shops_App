import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test/Data/LocalStorage/Cache_helper.dart';
import 'package:test/Presentaion/Constent/Method/navigation.dart';
import 'package:test/Presentaion/AppScreens/Boarding/Components/builed_boarding_on.dart';
import 'package:test/Presentaion/AppScreens/Boarding/Model/boarding_model.dart';
import 'package:test/Presentaion/AppScreens/Login/Screens/login_screen.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  List<BoardingModel> data = [
    BoardingModel(
      header: 'On boarder title 1',
      img: 'asset/image/login.ico',
      body: 'On boarder body 1',
    ),
    BoardingModel(
      header: 'On boarder title 2',
      img: 'asset/image/login.ico',
      body: 'On boarder body 2',
    ),
    BoardingModel(
      header: 'On boarder title 3',
      img: 'asset/image/login.ico',
      body: 'On boarder body 3',
    ),
  ];

  PageController boardingController = PageController();

  bool lastboarding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigation.navigationAndNotBack(
                  context: context,
                  page: const LoginScreen(),
                );
                CacheHelper.setData(key: 'onBoarding', value: true);
              },
              child: const Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.deepOrange,
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context, index) =>
                    builedBoardingOn(data: data[index]),
                itemCount: data.length,
                onPageChanged: (index) {
                  if (index == data.length - 1) {
                    setState(() {
                      lastboarding = true;
                    });
                  } else {
                    setState(() {
                      lastboarding = false;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: data.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 16,
                    dotWidth: 16,
                    dotColor: Colors.grey,
                    spacing: 5.0,
                    expansionFactor: 3.0,
                    activeDotColor: Colors.deepOrange,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (lastboarding == false) {
                      boardingController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else {
                      Navigation.navigationAndNotBack(
                        context: context,
                        page: const LoginScreen(),
                      );
                      CacheHelper.setData(key: 'onBoarding', value: true);
                    }
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
