import 'package:e_com/features/products/data/model/product_api_model.dart';

class ProductState {
  final List<ProductApiModel> products;
  final bool isLoading;
  final String? error;
  final ProductApiModel? productData;

  ProductState({
    required this.products,
    required this.isLoading,
    this.error,
    this.productData,
  });

  ProductState copyWith({
    List<ProductApiModel>? products,
    bool? isLoading,
    String? error,
    ProductApiModel? productData,
  }) {
    return ProductState(
      products: products ?? this.products,
      productData: productData ?? this.productData,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory ProductState.initial() => ProductState(
        products: [],
        productData: null,
        isLoading: false,
        error: null,
      );
}
