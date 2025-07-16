import 'package:e_com/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:e_com/features/cart/presentation/state/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>((
  ref,
) {
  return CartViewModel(ref.read(cartRemoteDataSourceProvider));
});

class CartViewModel extends StateNotifier<CartState> {
  final CartRemoteDatasource _dataSource;
  CartViewModel(this._dataSource) : super(CartState.initial());

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
}
