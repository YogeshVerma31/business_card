import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_reprensentable.dart';

enum AuthType { login, signUp }

class AuthApi extends APIRequestRepresentable {
  final AuthType authType;
  String? name;
  String? phoneNumber;
  String? password;
  String? email;

  AuthApi({required this.authType,
    this.name,
    this.phoneNumber,
    this.email,
    this.password,});

  @override
  get body {
    switch (authType) {
      case AuthType.login:
        return {"mobile_num": phoneNumber, "password": password};
      case AuthType.signUp:
        return {
          "name": name,
          "mobile_num": phoneNumber,
          "password": password,
          "email":email
        };
    }
  }

  @override
  String get endpoint => APIEndpoint.loginApi;

  @override
  Map<String, String>? get headers {
    return {
      "Content-type": "application/json"};
  }

  @override
  HTTPMethod get method {
    switch (authType) {
      case AuthType.login:
        return HTTPMethod.post;
      case AuthType.signUp:
        return HTTPMethod.post;
    }
  }

  @override
  String get path {
    switch (authType) {
      case AuthType.login:
        return APIEndpoint.loginApi;
      case AuthType.signUp:
        return APIEndpoint.signUpApi;
    }
  }

  @override
  Map<String, String>? get query => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => APIEndpoint.baseApi + path;

}
