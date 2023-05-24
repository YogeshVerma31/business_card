import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_ui/custom_button.dart';
import '../common_ui/custom_input_field.dart';
import '../controller/authentication_controller.dart';
import '../routes/app_routes_constant.dart';
import '../utils/color.dart';
import '../utils/styles.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  AuthController authController = Get.find();

  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(title:Text('SignUp')),
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
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sign Up",
                          style: headingStyle.copyWith(color: Colors.blue)),
                      // Text(
                      //   "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used.",
                      //   style: subtitleStyle.copyWith(color: Colors.black),
                      // )
                    ],
                  )),
              signUpForm
            ],
          ),
        ),
      )),
    );
  }

  Widget get signUpForm => Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: authController.nameController,
                  title: "Name",
                  hint: "Enter Name Number",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: authController.phoneController,
                  title: "Phone Number",
                  maxLength: 10,
                  textInputType: TextInputType.number,
                  hint: "Enter Your Phone Number",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: authController.emailController,
                  title: "Email",
                  hint: "Enter Email Number",
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                title: 'Confirm Password',
                hint: 'Enter your Confirm password',
                readOnly: false,
                controller: authController.confirmPasswordController,
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
                    label: 'SignUp',
                    onTap: () {
                      authController.checkSignUpValidation();
                    },
                    color: Colors.blue)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Registered?",
                  style: subtitleStyle.copyWith(color: textColorGrey),
                ),
                GestureDetector(
                    onTap: () {
                      Get.offNamed(RouteConstant.SIGINROUTE);
                    },
                    child: Text(
                      " Sign In",
                      style: subtitleStyle.copyWith(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    )),
              ],
            ),
          ],
        ),
      );
}
