import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset(
            'images/buisness_card.webp',
            width: MediaQuery
                .of(context)
                .size
                .width,
          ),
        ),
      ),
      );
  }
}
