class AuthEntity{
  AuthEntity({
    this.id,
    this.fullName,
    this.email,
    this.userName,
    this.phoneNumber,
    this.password,
    this.isAdmin,
    this.image
  });
    final String? id;
  final String? fullName;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final String? password;
  final bool? isAdmin;
  final String? image;
}