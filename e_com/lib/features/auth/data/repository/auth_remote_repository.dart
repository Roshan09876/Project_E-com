import 'package:dartz/dartz.dart';
import 'package:e_com/core/failure/failure.dart';
import 'package:e_com/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:e_com/features/auth/data/model/auth_api_model.dart';
import 'package:e_com/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final authRemoteRepositoryProvider = Provider<AuthRemoteRepository>(
    (ref) => AuthRemoteRepository(ref.watch(authRemoteDataSourceProvider)));

class AuthRemoteRepository implements IauthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRemoteRepository(this.authRemoteDatasource);
  @override
  Future<Either<Failure, bool>> register({
     required String name,
    required String email,
    required String password,
  }) async {
    return authRemoteDatasource.register(name: name, email: email,  password: password);
  }
  
  @override
  Future<Either<Failure, bool>> login(String userName, String password) async{
    return authRemoteDatasource.login(userName: userName, password: password);
  }
}