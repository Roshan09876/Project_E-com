// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(
  Map<String, dynamic> json,
) => ProductApiModel(
  id: json['_id'] as String?,
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

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
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
