// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
  id: json['_id'] as String?,
  fullName: json['fullName'] as String?,
  email: json['email'] as String?,
  userName: json['userName'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  password: json['password'] as String?,
  isAdmin: json['isAdmin'] as bool? ?? false,
  image: json['image'] as String? ?? '',
);

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'isAdmin': instance.isAdmin,
      'image': instance.image,
    };
