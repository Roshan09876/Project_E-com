import 'package:json_annotation/json_annotation.dart';


part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  AuthApiModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.isAdmin,
    this.cartData,
    this.v
  });
  @JsonKey(name: "_id")
   final String? id;
    final String? name;
    final String? email;
    final String? password;
    @JsonKey(defaultValue: false)
    final bool? isAdmin;
    final Map<String, int>? cartData;
    final int? v;
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  factory AuthApiModel.fromJson(Map<String, dynamic> json) => _$AuthApiModelFromJson(json);
}

