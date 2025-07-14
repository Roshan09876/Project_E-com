import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_com/config/constant/api_endpoints.dart';
import 'package:e_com/core/failure/failure.dart';
import 'package:e_com/core/network/http_service.dart';
import 'package:e_com/core/provider/flutter_secure_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDatasource>(
  (ref) => AuthRemoteDatasource(
    dio: ref.read(httpServiceProvider),
    flutterSecureStorage: ref.read(flutterSecureStorageProvider),
  ),
);

class AuthRemoteDatasource {
  final Dio dio;
  final FlutterSecureStorage flutterSecureStorage;
  AuthRemoteDatasource({required this.dio, required this.flutterSecureStorage});

  Future<Either<Failure, bool>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final url = ApiEndpoints.register;

      final response = await dio.post(
        url,
        data: {'name': name, 'email': email, 'password': password},
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
