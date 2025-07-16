import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_com/config/constant/api_endpoints.dart';
import 'package:e_com/core/failure/failure.dart';
import 'package:e_com/core/network/http_service.dart';
import 'package:e_com/core/provider/flutter_secure_storage_provider.dart';
import 'package:e_com/features/auth/data/model/auth_api_model.dart';
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
    required String firstName,
    required String lastName,
    required String email,
    required String userName,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final url = ApiEndpoints.register;

      final formData = FormData.fromMap({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'userName': userName,
        'phoneNumber': phoneNumber,
        'password': password,
      });

      final response = await dio.post(
        url,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
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

      final formData = FormData.fromMap({
        'userName': userName,
        'password': password,
      });

      final response = await dio.post(
        url,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userId = response.data['userData']['_id'];
        await flutterSecureStorage.write(key: "userId", value: userId);
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

    Future<Either<Failure, AuthApiModel>> getProfile() async {
    try {
      final userId = await flutterSecureStorage.read(key: 'userId');
      final url = "${ApiEndpoints.getProfile}/$userId";
      final response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['user'];
        final user = AuthApiModel.fromJson(data);
        return Right(user);
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
