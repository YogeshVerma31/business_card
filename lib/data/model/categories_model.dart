import 'package:json_annotation/json_annotation.dart';

part 'categories_model.g.dart';

@JsonSerializable()
class CategoriesModel {
  List<CategoriesData>? data;

  CategoriesModel({this.data});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);
}

@JsonSerializable()
class CategoriesData {
  String? uuid;
  String? name;

  CategoriesData({this.uuid, this.name});


  factory CategoriesData.fromJson(Map<String, dynamic> json) =>
      _$CategoriesDataFromJson(json);

// factory CategoriesData.fromJson(Map<String, dynamic> json) {
//   return CategoriesData(uuid: json['uuid'], name: json['name']);
// }
}