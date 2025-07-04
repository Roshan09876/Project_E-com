import 'package:e_com/features/products/data/model/product_api_model.dart';

class ProductState {
  final List<ProductApiModel> products;
  final bool isLoading;
  final String? error;

  ProductState({
    required this.products,
    required this.isLoading,
    this.error,
  });

  ProductState copyWith({
    List<ProductApiModel>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory ProductState.initial() => ProductState(
        products: [],
        isLoading: false,
        error: null,
      );
}
