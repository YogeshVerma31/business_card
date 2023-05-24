import 'dart:async';
import 'dart:io';

import 'package:buisness_card/constants/app_constants.dart';
import 'package:buisness_card/data/model/categories_model.dart';
import 'package:buisness_card/data/sharedPreference/shared_preference.dart';
import 'package:buisness_card/providers/network/api_endpoint.dart';
import 'package:buisness_card/ui/my_profile_screen.dart';
import 'package:get/get.dart';

import '../data/model/my_profile_model.dart';
import '../providers/network/api_provider.dart';

class HomeController extends GetxController {
  static const requestTimeOut = Duration(seconds: 25);
  final _client = GetConnect(timeout: requestTimeOut);

  var isLoading = true.obs;
  var selectCategories = ''.obs;

  var categoriesData = CategoriesModel().obs;
  var business = <dynamic>[].obs;
  var selectedCategoryUUid = '';
  var myProfileData = MyProfileModel().obs;


  businessCategoryUUid(String value) {
    selectedCategoryUUid = categoriesData.value.data!.where((element) => element.name==value).first.uuid!;
  }

  Future<void> fetchMyProfile() async {
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
      if(myProfileData.value.is_profile_completed==true){
        fetchCategories();
        fetchBusiness('', '', '');
      }else{
        Get.to(MyProfileScreen());
      }
      print("object + $myProfileData");
      update();
    } on TimeoutException {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<void> fetchCategories() async {

    try {
      print('HTTP REQUEST => ${'${APIEndpoint.baseApi}content/categories'}');
      // print('HTTP REQUEST => ${request.body}');
      final response = await _client.request(
        '${APIEndpoint.baseApi}content/categories',
        'GET',
        headers: {
          'Authorization':
          'Token ' + SharedPreference().getString(AppConstants().authToken)
        },
      );

      var result =
      _returnResponse(response, '${APIEndpoint.baseApi}content/categories');
      categoriesData.value = CategoriesModel.fromJson(result);
      selectCategories.value = categoriesData.value.data![0].name!;
      update();
    } on TimeoutException {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<void> updateProfile(String state, String city, String address,
      String description) async {
    businessCategoryUUid(selectCategories.value);
    isLoading(true);
    try {
      print('HTTP REQUEST => ${'${APIEndpoint.baseApi}auth/updateprofile'}');
      // print('HTTP REQUEST => ${request.body}');
      final response = await _client.request(
          '${APIEndpoint.baseApi}auth/updateprofile', 'PATCH',
          headers: {
            'Authorization': 'Token ' +
                SharedPreference().getString(AppConstants().authToken)
          },
          body: {
            'state': state,
            'city': city,
            'business_category': selectedCategoryUUid,
            'address': address,
            'description': description,
          });
      print('body-->${response.body}');
      print('requesttype-->${response.request!.method}');
      var result =
      _returnResponse(response, '${APIEndpoint.baseApi}auth/updateprofile');
      isLoading(false);
      update();
    } on TimeoutException {
      isLoading(false);

      throw TimeOutException(null);
    } on SocketException {
      isLoading(false);

      throw FetchDataException('No Internet connection');
    }
  }

  Future<void> fetchBusiness(String state, String city,
      String businessCat) async {
    try {
      print(
          'HTTP REQUEST => ${'${APIEndpoint
              .baseApi}auth/searchbusiness?state=$state&city=$city&category=$businessCat'}');
      // print('HTTP REQUEST => ${request.body}');
      final response = await _client.request(
        '${APIEndpoint
            .baseApi}auth/searchbusiness?state=$state&city=$city&category=$businessCat',
        'GET',
        headers: {
          'Authorization':
          'Token ' + SharedPreference().getString(AppConstants().authToken)
        },
      );

      var result = _returnResponse(response,
          '${APIEndpoint
              .baseApi}auth/searchbusiness?state=$state&city=$city&category=$businessCat');
      business.value = result['data'];
      print("object + $business");
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
