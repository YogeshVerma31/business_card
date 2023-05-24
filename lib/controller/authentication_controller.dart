import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../data/sharedPreference/shared_preference.dart';
import '../providers/network/api_provider.dart';
import '../routes/app_routes_constant.dart';
import '../data/repository/auth_repository_impl.dart';

class AuthController extends GetxController {
  var isPasswordVisible = false.obs;
  var isEditable = false.obs;
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _authRepository = AuthRepositoryImpl();
  var isLoading = false.obs;
  var isButtonLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
  }

  void checkValidation() {
    if (phoneController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone should not be empty!");
      return;
    } else if (phoneController.text.length < 10) {
      Fluttertoast.showToast(msg: "Phone number is not valid");
      return;
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password should not be empty!");
      return;
    } else {
      doSafeLogin();
    }
  }

  // void checkResetValidation() {
  //   if (oldPasswordController.text.isEmpty) {
  //     Fluttertoast.showToast(msg: "Old Password should not be empty!");
  //     return;
  //   } else if (newPasswordController.text.isEmpty) {
  //     Fluttertoast.showToast(msg: "New Password should not be empty!");
  //     return;
  //   } else if (confirmPasswordController.text.isEmpty) {
  //     Fluttertoast.showToast(msg: "Confirm Password should not be empty!");
  //     return;
  //   } else if (confirmPasswordController.text != newPasswordController.text) {
  //     Fluttertoast.showToast(msg: "Confirm Password Not Matched!");
  //     return;
  //   } else {}
  // }
  //
  void checkSignUpValidation() {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Name should not be empty!");
    } else if (emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Email is not empty");
      return;
    } else if (!emailController.text.isEmail) {
      Fluttertoast.showToast(msg: "Email is not valid");
      return;
    } else if (phoneController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone should not be empty!");
      return;
    } else if (phoneController.text.length < 10) {
      Fluttertoast.showToast(msg: "Phone number is not valid");
      return;
    } else if (passwordController.text.isEmail) {
      Fluttertoast.showToast(msg: "password is Not valid!");
      return;
    } else if (confirmPasswordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Confirm Password should not be empty!");
      return;
    } else if (!(passwordController.text == confirmPasswordController.text)) {
      Fluttertoast.showToast(msg: "password not match");
      return;
    } else {
      doSafeSignUp();
    }
  }

  Future<void> doSafeLogin() async {
    isLoading(true);
    try {
      final loginResponse = await _authRepository.signIn(
          phoneController.text, passwordController.text);
      isLoading(false);
      putToken(loginResponse!.token!);
      Fluttertoast.showToast(msg: loginResponse.message!);
      Get.offAllNamed(RouteConstant.HOMEROUTE);
    } on FetchDataException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on BadRequestException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on UnauthorisedException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.message.toString());
    }
  }

  void putToken(String authToken) {
    SharedPreference().putString(AppConstants().authToken, authToken);
  }

  Future<void> doSafeSignUp() async {
    isLoading(true);
    try {
      final signUpResponse = await _authRepository.signUp(
        nameController.text,
        passwordController.text,
        emailController.text,
        phoneController.text
      );
      isLoading(false);
      putToken(signUpResponse!.token!);
      Fluttertoast.showToast(msg: signUpResponse!.message!);
      Get.offAllNamed(RouteConstant.HOMEROUTE);
    } on FetchDataException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on BadRequestException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on UnauthorisedException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    }
  }

// Future<void> initiateFacebookLogin() async {
//   final loginResult = await FacebookAuth.instance.login();
//
//   if (loginResult.status == LoginStatus.success) {
//     print(loginResult.accessToken);
//     final userInfo = await FacebookAuth.instance.getUserData();
//     print(userInfo.toString());
//   } else {
//     print('ResultStatus: ${loginResult.status}');
//     print('Message: ${loginResult.message}');
//   }
// }
//
// Future<void> doForgetPassword() async {
//   isLoading(true);
//   try {
//     final signUpResponse =
//     await _authRepository.forgetPassword(emailController.text);
//     isLoading(false);
//     Fluttertoast.showToast(msg: signUpResponse.message!);
//   } on FetchDataException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   } on BadRequestException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   } on UnauthorisedException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   }
// }
//
// Future<void> doResetPassword() async {
//   isLoading(true);
//   try {
//     final signUpResponse =
//     await _authRepository.forgetPassword(emailController.text);
//     isLoading(false);
//     Fluttertoast.showToast(msg: signUpResponse.message!);
//   } on FetchDataException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   } on BadRequestException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   } on UnauthorisedException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   }
// }
}
