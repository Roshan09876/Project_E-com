class ProductEntity {
  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.productType,
    required this.productPrice,
    required this.discountPrice,
    required this.image,
  });
  final String id;
  final String title;
  final String description;
  final String productType;
  final String productPrice;
  final String discountPrice;
  final String image;
}
