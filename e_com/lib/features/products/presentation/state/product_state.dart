import 'package:e_com/features/products/data/model/product_api_model.dart';

class ProductState {
  final List<ProductApiModel> products;
  final ProductApiModel? singleProduct;
  final bool isLoading;
  final String? error;

  ProductState({
    required this.products,
     this.singleProduct,
    required this.isLoading,
    this.error,
  });

  ProductState copyWith({
    List<ProductApiModel>? products,
    ProductApiModel? singleProduct,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      singleProduct: singleProduct ?? this.singleProduct,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory ProductState.initial() => ProductState(
        products: [],
        singleProduct: null,
        isLoading: false,
        error: null,
      );
}
