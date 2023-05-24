import 'package:json_annotation/json_annotation.dart';

part 'my_profile_model.g.dart';

@JsonSerializable()
class MyProfileModel {
  String? name;
  int? mobile_num;
  String? email;
  String? state;
  String? city;
  String? address;
  String? description;
  String? profile_image;
  bool? is_profile_completed;
  BusinessCategoryModel? business_category;
  List<BusinessImagesModel>? business_images;
  List<BusinessFeedbackModel>? business_feedbacks;

  MyProfileModel(
      {this.name,
      this.mobile_num,
      this.email,
      this.state,
      this.city,
      this.address,
      this.description,
      this.profile_image,
      this.is_profile_completed,
      this.business_category,
      this.business_images,
      this.business_feedbacks});

  factory MyProfileModel.fromJson(Map<String, dynamic> json) =>
      _$MyProfileModelFromJson(json);
}

@JsonSerializable()
class BusinessCategoryModel {
  String? uuid;
  String? name;

  BusinessCategoryModel({this.name, this.uuid});

  factory BusinessCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessCategoryModelFromJson(json);
}

@JsonSerializable()
class BusinessImagesModel {
  String? uuid;
  String? image;
  String? user;

  BusinessImagesModel({this.uuid, this.image, this.user});

  factory BusinessImagesModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessImagesModelFromJson(json);
}

@JsonSerializable()
class BusinessFeedbackModel {
  String? uuid;
  String? description;
  String? given_by_name;
  String? user;
  String? given_by;
  String? created_at;

  BusinessFeedbackModel(
      {this.uuid,
      this.description,
      this.user,
      this.given_by,
        this.created_at,
      this.given_by_name});

  factory BusinessFeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessFeedbackModelFromJson(json);
}
