import 'package:dartz/dartz.dart';
import 'package:e_com/core/failure/failure.dart';
import 'package:e_com/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:e_com/features/auth/domain/usecase/login_usecase.dart';
import 'package:e_com/features/auth/domain/usecase/register_usecase.dart';
import 'package:e_com/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDatasource {}
class MockLoginUseCase extends Mock implements LoginUsecase {}

class MockRegisterUseCase extends Mock implements RegisterUsecase {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockLoginUseCase mockLoginUseCase;
  late FakeBuildContext fakeContext;
  late AuthViewModel authViewModel;

  // Register fallback value for BuildContext used in mocks
  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() {
    fakeContext = FakeBuildContext();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    authViewModel = AuthViewModel(mockAuthRemoteDataSource, mockRegisterUseCase, mockLoginUseCase);
  });

  test('initial state should not be loading', () {
    expect(authViewModel.state.isLoading, false);
  });

  test('successfully login updates user state', () async {
    // Arrange
    when(
      () => mockLoginUseCase.login(
        userName: any(named: 'userName'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(true));

    // Act
    await authViewModel.login(
      userName: 'Rahul',
      password: '00000000',
      context: fakeContext,
    );

    // Assert
    expect(authViewModel.state.isLoading, false);
    expect(authViewModel.state.showMessage, true); 
    expect(authViewModel.state.error, null);
  });

  test('failed login sets error message', () async {
    // Arrange
    when(
      () => mockLoginUseCase.login(
        userName: any(named: 'userName'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => Left(Failure(error: 'Invalid credentials')));

    // Act
    await authViewModel.login(
      userName: 'wronguser',
      password: 'wrongpass',
      context: fakeContext,
    );

    // Assert
    expect(authViewModel.state.isLoading, false);
    expect(authViewModel.state.showMessage, true);  
    expect(authViewModel.state.error, 'Invalid credentials');
  });
}
