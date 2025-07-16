import 'package:e_com/features/cart/presentation/state/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider<CartViewModel, CartState>((
  ref,
) {
  return CartViewModel();
});

class CartViewModel extends StateNotifier<CartState> {
  CartViewModel() : super(CartState.initial());
}
