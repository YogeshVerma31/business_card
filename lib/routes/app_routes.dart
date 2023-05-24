// import 'package:car_parts/bindings/auth_binding.dart';
// import 'package:car_parts/bindings/car_binding.dart';
// import 'package:car_parts/controller/splash_binding.dart';
// import 'package:car_parts/ui/homepage_screen.dart';
// import 'package:car_parts/ui/login_screen.dart';
// import 'package:car_parts/ui/my_order_screen.dart';
// import 'package:car_parts/ui/my_profile.dart';
// import 'package:car_parts/ui/place_order.dart';
// import 'package:car_parts/ui/signup_screen.dart';
// import 'package:car_parts/ui/splash_page.dart';
// import 'package:get/get_navigation/src/routes/get_route.dart';
//
// import 'app_routes_constant.dart';

import 'package:buisness_card/ui/home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../bindings/auth_binding.dart';
import '../bindings/home_binding.dart';
import '../controller/splash_binding.dart';
import '../ui/login_screen.dart';
import '../ui/signup_screen.dart';
import '../ui/splash_page.dart';
import 'app_routes_constant.dart';

class Routes {
  static final routes = [
    GetPage(
        name: RouteConstant.SIGINROUTE,
        page: () => LoginScreen(),
        binding: AuthBinding()),
    GetPage(
        name: RouteConstant.SIGNUPROUTE,
        binding: AuthBinding(),
        page: () => SignUpScreen()),
    GetPage(
        name: RouteConstant.INITIALROUTE,
        page: () => SplashScreen(),
        binding: SplashBinding()

    ),
    GetPage(
        name: RouteConstant.HOMEROUTE,
        binding: HomeBinding(),
        page: () => HomeScreen()),
  ];
}
