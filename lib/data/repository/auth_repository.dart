import '../model/login_model.dart';

abstract class AuthRepository {
  Future<LoginModel>? signIn(String email, String password);

  Future<LoginModel>? signUp(
      String name,
      String password,
      String email,
      String phone,
      );

}
