import 'package:e_com/config/constant/show_snackbar.dart';
import 'package:e_com/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:e_com/features/cart/presentation/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>((
  ref,
) {
  return CartViewModel(ref.read(cartRemoteDataSourceProvider));
});

class CartViewModel extends StateNotifier<CartState> {
  final CartRemoteDatasource _dataSource;
  CartViewModel(this._dataSource) : super(CartState.initial());

  Future<void> addToCart({
    required String productId,
    required int quantity,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await _dataSource.addToCart(
      productId: productId,
      quantity: quantity,
    );

    result.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        showSnackBar(
          message: "Product Added to Cart",
          context: context,
          color: Colors.green,
          icon: Icons.done,
        );
        return state = state.copyWith(isLoading: false, error: null);
      },
    );
  }

  Future<void> fetchUserCart() async {
    state = state.copyWith(isLoading: true);
    final result = await _dataSource.getAllCart();
    result.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(
        cartApiModel: r,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<String?> getUserIdFromStorage() async {
    return await _dataSource.flutterSecureStorage.read(key: 'userId');
  }

  Future<void> removeCartItem({
    required String userId,
    required String productId,
    required BuildContext context
  }) async {
    final result = await _dataSource.removeFromCart(
      userId: userId,
      productId: productId,
    );
    result.fold((l) => state = state.copyWith(error: l.error), (r) async {
      showSnackBar(message: 'Item removed from cart', context: context, 
      color: Colors.green,
      icon: Icons.done
      );
      await fetchUserCart();
    });
  }
}
