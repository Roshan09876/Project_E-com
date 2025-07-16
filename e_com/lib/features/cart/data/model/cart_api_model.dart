// cart_api_model.dart
import 'package:e_com/features/products/data/model/product_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_api_model.g.dart';

@JsonSerializable()
class CartApiModel {
  CartApiModel({
    this.product,
    this.quantity,
  });

  final ProductApiModel? product;
  final int? quantity;

  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);
}