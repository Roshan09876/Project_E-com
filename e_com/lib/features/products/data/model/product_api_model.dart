import 'package:json_annotation/json_annotation.dart';

part 'product_api_model.g.dart';

@JsonSerializable()
class ProductApiModel {
  ProductApiModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.category,
    this.subCategory,
    this.sizes,
    this.bestSeller,
    this.date,
    this.v,
  });
  @JsonKey(name: "_id")
  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final List<String>? image;
  final String? category;
  final String? subCategory;
  final List<String>? sizes;
  final bool? bestSeller;
  final int? date;
  final int? v;

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);
}
