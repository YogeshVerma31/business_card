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

class SearchController extends GetxController {
  static const requestTimeOut = Duration(seconds: 25);
  final _client = GetConnect(timeout: requestTimeOut);

  var isLoading = false.obs;
  var selectCategories = ''.obs;

  var categoriesData = CategoriesModel().obs;
  var business = <dynamic>[].obs;
  var recentSearches = <dynamic>[].obs;
  var selectedCategoryUUid = '';
  var myProfileData = MyProfileModel().obs;

  Future<void> fetchRecentSearch() async {
    try {
      // print('HTTP REQUEST => ${request.body}');
      final response = await _client.request(
        '${APIEndpoint.baseApi}auth/recentsearch',
        'GET',
        headers: {
          'Authorization':
              'Token ' + SharedPreference().getString(AppConstants().authToken)
        },
      );

      var result =
          _returnResponse(response, '${APIEndpoint.baseApi}auth/recentsearch');

      print("object + ${result}");
      recentSearches.value = result['data'];

      update();
    } on TimeoutException {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<void> fetchSearchBusiness(String searchText) async {
    isLoading(true);
    try {
      print(
          'HTTP REQUEST => ${'${APIEndpoint.baseApi}auth/searchbusiness?search=$searchText'}');
      // print('HTTP REQUEST => ${request.body}');
      final response = await _client.request(
        '${APIEndpoint.baseApi}auth/searchbusiness?search=$searchText',
        'GET',
        headers: {
          'Authorization':
              'Token ' + SharedPreference().getString(AppConstants().authToken)
        },
      );

      var result = _returnResponse(response,
          '${APIEndpoint.baseApi}auth/searchbusiness?search=$searchText');
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
