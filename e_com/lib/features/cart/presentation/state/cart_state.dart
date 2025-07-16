import 'package:e_com/features/cart/data/model/cart_api_model.dart';

class CartState {
  final bool isLoading;
  final String? error;
  final List<CartApiModel>? cartApiModel;

  CartState({required this.isLoading, this.error, this.cartApiModel});

  factory CartState.initial() {
    return CartState(isLoading: false, error: null, cartApiModel: []);
  }

  CartState copyWith({
    bool? isLoading,
    String? error,
    List<CartApiModel>? cartApiModel,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      cartApiModel: cartApiModel ?? this.cartApiModel,
    );
  }
}
