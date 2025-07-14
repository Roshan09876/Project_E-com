// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthEntity {

   final String? id;
    final String? name;
    final String? email;
    final String? password;
    final bool? isAdmin;
    final Map<String, int>? cartData;
    final int? v;
  AuthEntity({
    this.id,
    this.name,
    this.email,
    this.password,
    this.isAdmin,
    this.cartData,
    this.v,
  });
}
