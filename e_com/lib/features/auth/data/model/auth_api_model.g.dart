// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
  id: json['_id'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  userName: json['userName'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  password: json['password'] as String?,
  isAdmin: json['isAdmin'] as bool? ?? false,
  image: json['image'] as String? ?? '',
  cartData: (json['cartData'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toInt()),
  ),
);

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'cartData': instance.cartData,
      'isAdmin': instance.isAdmin,
      'image': instance.image,
    };
