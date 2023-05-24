import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../data/model/my_profile_model.dart';
import '../data/sharedPreference/shared_preference.dart';
import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';
import '../services/media_services.dart';
import '../services/media_services_interface.dart';

class ImagesController extends GetxController {
  static const requestTimeOut = Duration(seconds: 25);
  final _client = GetConnect(timeout: requestTimeOut);
  final isLoading = false.obs;

  var myProfileData = MyProfileModel().obs;
  String imageFileName = '';
  dynamic imageFile;

  Future<void> getPhoto(menuOptions options, bool isPhoto, context) async {
    final dynamic pickedFile = isPhoto
        ? await MediaService().uploadSingleImage(context, options)
        : await MediaService().uploadVideo(context, options);
    if (pickedFile == null) return;
    if (isPhoto) {
      imageFile = pickedFile;
      imageFileName = pickedFile.path;
    }
    postChat('');
  }

  Future<void> postChat(String message) async {
    isLoading(true);

    try {
      final http.MultipartRequest request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://businesscards.codvensolutions.com/api/content/productimage'));

      if (imageFileName != '') {
        final http.MultipartFile videoFIle = await http.MultipartFile.fromPath(
            'image', File(imageFile.path).path);
        request.files.add(videoFIle);
      }
      final Map<String, String> headers = {
        'Authorization':
            'token ${SharedPreference().getString(AppConstants().authToken)}',
        'Content-type': 'multipart/form-data'
      };
      request.headers.addAll(headers);
      final res = await request.send();
      final response = await http.Response.fromStream(res);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode != null && response.statusCode != 200) {
        throw Exception(response.body);
      }
      final result = json.decode(response.body);
      Fluttertoast.showToast(msg: result['message']);
      print(result['message']);
      imageFileName = '';
      imageFile = '';
      isLoading(false);
      fetchMyProfile();
      return result;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> fetchMyProfile() async {
    isLoading(true);
    try {
      // print('HTTP REQUEST => ${request.body}');
      final response = await _client.request(
        '${APIEndpoint.baseApi}auth/checkprofile',
        'GET',
        headers: {
          'Authorization':
              'Token ' + SharedPreference().getString(AppConstants().authToken)
        },
      );
      var result =
          _returnResponse(response, '${APIEndpoint.baseApi}auth/checkprofile');
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
