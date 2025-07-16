import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_com/config/constant/api_endpoints.dart';
import 'package:e_com/core/failure/failure.dart';
import 'package:e_com/core/network/http_service.dart';
import 'package:e_com/core/provider/flutter_secure_storage_provider.dart';
import 'package:e_com/features/cart/data/model/cart_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final cartRemoteDataSourceProvider = Provider<CartRemoteDatasource>(
  (ref) => CartRemoteDatasource(
    dio: ref.read(httpServiceProvider),
    flutterSecureStorage: ref.read(flutterSecureStorageProvider),
  ),
);

class CartRemoteDatasource {
  final Dio dio;
  final FlutterSecureStorage flutterSecureStorage;
  CartRemoteDatasource({required this.dio, required this.flutterSecureStorage});

  Future<Either<Failure, List<CartApiModel>>> getAllCart() async {
    try {
      final userId = await flutterSecureStorage.read(key: 'userId');
      final url = '${ApiEndpoints.allCart}/$userId';
      final response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final cartjson = data['cart'] as List;
        final cartItem = cartjson
            .map((json) => CartApiModel.fromJson(json))
            .toList();
        return Right(cartItem);
      } else {
        return Left(
          Failure(
            error: response.data['message'] ?? 'Unexpected error',
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } catch (e) {
      return Left(Failure(error: 'cart Failed'));
    }
  }

  Future<Either<Failure, bool>> login({
    required String userName,
    required String password,
  }) async {
    try {
      final url = ApiEndpoints.login;
      final response = await dio.post(
        url,
        data: {'email': userName, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'] ?? 'Unexpected error',
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(error: e.response?.data['message'] ?? 'Registration failed'),
      );
    }
  }
}
