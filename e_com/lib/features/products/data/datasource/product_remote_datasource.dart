// product_remote_datasource.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_com/config/constant/api_endpoints.dart';
import 'package:e_com/core/failure/failure.dart';
import 'package:e_com/core/network/http_service.dart';
import 'package:e_com/features/products/data/model/product_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  final dio = ref.read(httpServiceProvider);
  return ProductRemoteDataSource(dio);
});

class ProductRemoteDataSource {
  final Dio dio;
  ProductRemoteDataSource(this.dio);

 Future<Either<Failure, List<ProductApiModel>>> getAllProducts() async {
  try {
    final response = await dio.get(ApiEndpoints.allProducts);
    if (response.statusCode == 200) {
      final data = response.data;
      final productsJson = data['products'] as List;
      final products = productsJson
          .map((json) => ProductApiModel.fromJson(json))
          .toList();
      return Right(products);
    } else {
      return Left(Failure(error: 'Failed to fetch products'));
    }
  } catch (e) {
    return Left(Failure(error: e.toString()));
  }
}

}
