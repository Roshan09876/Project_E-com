// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  price: (json['price'] as num?)?.toInt(),
  image: (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
  category: json['category'] as String?,
  subCategory: json['subCategory'] as String?,
  sizes: (json['sizes'] as List<dynamic>?)?.map((e) => e as String).toList(),
  bestSeller: json['bestSeller'] as bool?,
  date: (json['date'] as num?)?.toInt(),
  v: (json['v'] as num?)?.toInt(),
);

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'sizes': instance.sizes,
      'bestSeller': instance.bestSeller,
      'date': instance.date,
      'v': instance.v,
    };
