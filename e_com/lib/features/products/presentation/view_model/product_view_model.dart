// product_view_model.dart
import 'package:e_com/features/products/data/datasource/product_remote_datasource.dart';
import 'package:e_com/features/products/presentation/state/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>((ref) {
  final dataSource = ref.read(productRemoteDataSourceProvider);
  return ProductViewModel(dataSource);
});

class ProductViewModel extends StateNotifier<ProductState> {
  final ProductRemoteDataSource _dataSource;

  ProductViewModel(this._dataSource) : super(ProductState.initial());

  Future<void> fetchProducts() async {
    state = state.copyWith(isLoading: true);
    final result = await _dataSource.getAllProducts();
    result.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(products: r, isLoading: false, error: null),
    );
  }


}
