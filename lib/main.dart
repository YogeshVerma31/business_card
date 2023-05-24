
import 'package:buisness_card/routes/app_routes.dart';
import 'package:buisness_card/routes/app_routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'data/sharedPreference/shared_preference.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
      initialRoute: RouteConstant.INITIALROUTE,
    );
  }
}
