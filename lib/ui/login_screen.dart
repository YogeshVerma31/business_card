import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_ui/custom_button.dart';
import '../common_ui/custom_input_field.dart';
import '../controller/authentication_controller.dart';
import '../routes/app_routes_constant.dart';
import '../utils/color.dart';
import '../utils/styles.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var authController = Get.put(AuthController());

  final phoneNumberController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(title: Text('Login')),
      body: SafeArea(
          child: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  'images/buisness_card.webp',
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sign In",
                          style: headingStyle.copyWith(color: Colors.blue)),
                      // Text(
                      //   "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used.",
                      //   style: subtitleStyle.copyWith(color: Colors.black),
                      // )
                    ],
                  )),
              loginForm
            ],
          ),
        ),
      )),
    );
  }

  Widget get loginForm => Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: authController.phoneController,
                  title: "Phone",
                  maxLength: 10,
                  textInputType: TextInputType.number,
                  hint: "Enter Phone Number",
                  readOnly: false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                title: 'Password',
                hint: 'Enter your password',
                readOnly: false,
                controller: authController.passwordController,
                obscureText: authController.isPasswordVisible.value,
                widget: IconButton(
                  color: greyColor,
                  icon: authController.isPasswordVisible.isTrue
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.remove_red_eye),
                  onPressed: () => authController.isPasswordVisible.value =
                      !authController.isPasswordVisible.value,
                ),
              ),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CustomButton(
                    isProgressBar: authController.isLoading.value,
                    label: 'SignIn',
                    onTap: () {
                      authController.checkValidation();
                    },
                    color: Colors.blue)),
            Text(
              "Don’t you have an account?",
              style: subtitleStyle.copyWith(color: textColorGrey),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  Get.offNamed(RouteConstant.SIGNUPROUTE);
                },
                child: Text(
                  "Create Account",
                  style: subtitleStyle.copyWith(
                      color: Colors.blue, decoration: TextDecoration.underline),
                )),
          ],
        ),
      );
}
