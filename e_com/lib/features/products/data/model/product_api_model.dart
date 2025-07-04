import 'package:json_annotation/json_annotation.dart';

part 'product_api_model.g.dart';

@JsonSerializable()
class ProductApiModel {
  @JsonKey(name: "_id")
  final String id;
  final String title;
  final String description;
  final String productType;
  final String productPrice;
  final String image;
  ProductApiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.productType,
    required this.productPrice,
    required this.image,
  });

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);
}
