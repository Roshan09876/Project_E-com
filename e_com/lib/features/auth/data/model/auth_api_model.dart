import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: "_id")
  final String? id;
  final String? fullName;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final String? password;

  @JsonKey(defaultValue: false)
  final bool isAdmin;

  @JsonKey(defaultValue: '')
  final String image;

  AuthApiModel({
    this.id,
    this.fullName,
    this.email,
    this.userName,
    this.phoneNumber,
    this.password,
    this.isAdmin = false,
    this.image = '',
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);
}
