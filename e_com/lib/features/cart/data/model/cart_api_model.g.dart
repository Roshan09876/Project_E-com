// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
  product: json['product'] == null
      ? null
      : ProductApiModel.fromJson(json['product'] as Map<String, dynamic>),
  quantity: (json['quantity'] as num?)?.toInt(),
);

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
    };
