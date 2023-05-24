import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../data/sharedPreference/shared_preference.dart';
import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';

class FeedBackController extends GetxController{
  var nameController = TextEditingController();
  var commentController = TextEditingController();
  static const requestTimeOut = Duration(seconds: 25);
  final _client = GetConnect(timeout: requestTimeOut);
  var isLoading = false.obs;


  Future<void> addFeedback(String businessUuid) async {
    isLoading.value = true;
    try {
      final response = await _client.request(
        '${APIEndpoint.baseApi}content/businessfeedback',
        'POST',
        headers: {
          'Authorization': 'Token ' + SharedPreference().getString(AppConstants().authToken)
        },
        body: {'description':commentController.text,'business_uuid':businessUuid}
      );
      var result = _returnResponse(response, '${APIEndpoint.baseApi}auth/checkprofile');
      Fluttertoast.showToast(msg: result['message']);
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