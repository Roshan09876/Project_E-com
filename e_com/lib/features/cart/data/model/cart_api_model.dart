import 'package:json_annotation/json_annotation.dart';
part 'cart_api_model.g.dart';

@JsonSerializable()
class CartApiModel{
  CartApiModel({
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
    this.v
  });
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
  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  factory CartApiModel.fromJson(Map<String, dynamic> json) => _$CartApiModelFromJson(json);
}