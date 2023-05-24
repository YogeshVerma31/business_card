import '../../../providers/network/apis/auth_api.dart';
import '../model/login_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<LoginModel>? signIn(String email, String password) async {
    final response = await AuthApi(
            phoneNumber: email, password: password, authType: AuthType.login)
        .request();
    return LoginModel.fromJson(response);
  }

  @override
  Future<LoginModel>? signUp(
    String name,
    String password,
    String email,
    String phone,
  ) async {
    final response = await AuthApi(
            name: name,
        phoneNumber: phone,
            email: email,
            password: password,
            authType: AuthType.signUp)
        .request();
    return LoginModel.fromJson(response);
  }
}
