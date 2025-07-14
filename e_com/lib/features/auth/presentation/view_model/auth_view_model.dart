import 'package:e_com/config/constant/show_snackbar.dart';
import 'package:e_com/config/router/app_routes.dart';
import 'package:e_com/features/auth/data/model/auth_api_model.dart';
import 'package:e_com/features/auth/domain/usecase/login_usecase.dart';
import 'package:e_com/features/auth/domain/usecase/register_usecase.dart';
import 'package:e_com/features/auth/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((
  ref,
) {
  return AuthViewModel(ref.read(registerUsecaseProvider), ref.read(loginUsecaseProvider));
});

class AuthViewModel extends StateNotifier<AuthState> {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;

  AuthViewModel(this.registerUsecase, this.loginUsecase) : super(AuthState.initial());

  Future<void> register({
     required String name,
    required String email,
    required String password,
    required BuildContext context
  }) async {
    state = state.copyWith(isLoading: false);
    final result = await registerUsecase.register(name: name, email: email, password: password);

    result.fold(
      (failure) {
        state = state.copyWith(error: failure.error, showMessage: true);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          showMessage: true,
        );
        EasyLoading.show(
          status: 'Please Wait...',
          maskType: EasyLoadingMaskType.black,
        );
        Future.delayed(const Duration(seconds: 2), () {
          EasyLoading.showSuccess('Register Successfully');
          Navigator.pushNamed(context, AppRoutes.loginRoute);
          EasyLoading.dismiss();
        });
      },
    );
  }

  Future<void> login(
     {
      required String userName, required String password, required BuildContext context
     }) async {
    state = state.copyWith(isLoading: true);
    final result = await loginUsecase.login(userName: userName, password: password);
    result.fold((failure) {
      state = state.copyWith(
        error: failure.error.toString(),
        showMessage: true,
        isLoading: false
      );
      showSnackBar(
          message: failure.error.toString(),
          context: context,
          color: Colors.red);
    }, (success) {
      state = state.copyWith(
        isLoading: false,
        error: null,
        showMessage: true,
      );
            // EasyLoading.show(status: 'Please Wait...', maskType: EasyLoadingMaskType.black);

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, AppRoutes.bootomNavRoute);
      // EasyLoading.showSuccess('Loggedin in',);
        // EasyLoading.dismiss();
      });
    });
  }
}

class AppRoute {
}
