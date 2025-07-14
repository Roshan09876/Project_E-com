// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  password: json['password'] as String?,
  isAdmin: json['isAdmin'] as bool? ?? false,
  cartData: (json['cartData'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toInt()),
  ),
  v: (json['v'] as num?)?.toInt(),
);

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'isAdmin': instance.isAdmin,
      'cartData': instance.cartData,
      'v': instance.v,
    };
