class CartEntity{
  CartEntity({
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
}