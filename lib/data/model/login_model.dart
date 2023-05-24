import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginModel {
  String? message;
  String? token;

  LoginModel({this.message, this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(message: json['message'], token: json['token']);
  }
}
