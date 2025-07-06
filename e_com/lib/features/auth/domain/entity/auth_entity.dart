class AuthEntity{
  AuthEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.phoneNumber,
    this.password,
    this.isAdmin,
    this.image
  });
    final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final String? password;
  final bool? isAdmin;
  final String? image;
}