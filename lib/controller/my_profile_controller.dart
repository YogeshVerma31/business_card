import 'dart:async';
import 'dart:io';

import 'package:buisness_card/data/model/my_profile_model.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../data/sharedPreference/shared_preference.dart';
import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class MyProfileController extends GetxController {
  static const requestTimeOut = Duration(seconds: 25);
  final _client = GetConnect(timeout: requestTimeOut);

  var isLoading = true.obs;
  var myProfileData = MyProfileModel().obs;

  @override
  void onInit() {
    fetchMyProfile();
    super.onInit();
  }

  Future<void> fetchMyProfile() async {
    isLoading(true);
    try {
      // print('HTTP REQUEST => ${request.body}');
      final response = await _client.request(
        '${APIEndpoint.baseApi}auth/checkprofile',
        'GET',
        headers: {
          'Authorization': 'Token ' + SharedPreference().getString(AppConstants().authToken)
        },
      );
      var result = _returnResponse(response, '${APIEndpoint.baseApi}auth/checkprofile');
      myProfileData.value = MyProfileModel.fromJson(result['data']);
      print("object + $myProfileData");
      update();
    } on TimeoutException {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(Response<dynamic> response, String url) {
    isLoading.value = false;
    switch (response.statusCode) {
      case 200:
        print("HTTP 200 ok==>$url");
        print("Response==> ${response.body}");
        return response.body;
      case 400:
        print('HTTP RESPONSE => 400');
        throw BadRequestException(response.body['message'].toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw BadRequestException('Not found');
      case 500:
        throw FetchDataException('Internal Server Error');
      default:
        throw FetchDataException('No Internet Connection');
    }
  }
}
