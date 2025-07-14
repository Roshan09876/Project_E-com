import 'package:dartz/dartz.dart';
import 'package:e_com/core/failure/failure.dart';
import 'package:e_com/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerUsecaseProvider =
    Provider.autoDispose<RegisterUsecase>((ref) => RegisterUsecase(ref.read(iauthRepositoryProvider)));

class RegisterUsecase {
  final IauthRepository iauthRepository;
  RegisterUsecase(this.iauthRepository);

  Future<Either<Failure, bool>> register({
     required String name,
    required String email,
    required String password,
  }) {
    return iauthRepository.register(name: name, email: email,  password: password);
  }
}