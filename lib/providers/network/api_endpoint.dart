class APIEndpoint {
  //base Api end point
  static String get baseApi => "https://businesscards.codvensolutions.com/api/";
  static String get baseImageApi => "https://businesscards.in/demo/autopart/";

  //auth Api end points
  static String get loginApi => "auth/login";

  static String get signUpApi => "auth/register";
  static String get myProfileApi => "user";

  static String get carBrandApi => "car";
  static String get carByIdApi => "models/bycarid/";

  static String get changePasswordApi => "/auth/password/change";

  //Sort Api
  static String get locationListApi => "/location/list/";


}
