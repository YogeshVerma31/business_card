// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileModel _$MyProfileModelFromJson(Map<String, dynamic> json) =>
    MyProfileModel(
      name: json['name'] as String?,
      mobile_num: json['mobile_num'] as int?,
      email: json['email'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      profile_image: json['profile_image'] as String?,
      is_profile_completed: json['is_profile_completed'] as bool?,
      business_category: json['business_category'] == null
          ? null
          : BusinessCategoryModel.fromJson(
              json['business_category'] as Map<String, dynamic>),
      business_images: (json['business_images'] as List<dynamic>?)
          ?.map((e) => BusinessImagesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      business_feedbacks: (json['business_feedbacks'] as List<dynamic>?)
          ?.map(
              (e) => BusinessFeedbackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyProfileModelToJson(MyProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile_num': instance.mobile_num,
      'email': instance.email,
      'state': instance.state,
      'city': instance.city,
      'address': instance.address,
      'description': instance.description,
      'profile_image': instance.profile_image,
      'is_profile_completed': instance.is_profile_completed,
      'business_category': instance.business_category,
      'business_images': instance.business_images,
      'business_feedbacks': instance.business_feedbacks,
    };

BusinessCategoryModel _$BusinessCategoryModelFromJson(
        Map<String, dynamic> json) =>
    BusinessCategoryModel(
      name: json['name'] as String?,
      uuid: json['uuid'] as String?,
    );

Map<String, dynamic> _$BusinessCategoryModelToJson(
        BusinessCategoryModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
    };

BusinessImagesModel _$BusinessImagesModelFromJson(Map<String, dynamic> json) =>
    BusinessImagesModel(
      uuid: json['uuid'] as String?,
      image: json['image'] as String?,
      user: json['user'] as String?,
    );

Map<String, dynamic> _$BusinessImagesModelToJson(
        BusinessImagesModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'image': instance.image,
      'user': instance.user,
    };

BusinessFeedbackModel _$BusinessFeedbackModelFromJson(
        Map<String, dynamic> json) =>
    BusinessFeedbackModel(
      uuid: json['uuid'] as String?,
      description: json['description'] as String?,
      user: json['user'] as String?,
      given_by: json['given_by'] as String?,
      created_at: json['created_at'] as String?,
      given_by_name: json['given_by_name'] as String?,
    );

Map<String, dynamic> _$BusinessFeedbackModelToJson(
        BusinessFeedbackModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'description': instance.description,
      'given_by_name': instance.given_by_name,
      'user': instance.user,
      'given_by': instance.given_by,
      'created_at': instance.created_at,
    };
