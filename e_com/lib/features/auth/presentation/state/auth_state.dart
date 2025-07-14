import 'package:e_com/features/auth/data/model/auth_api_model.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final bool? showMessage;
  final AuthApiModel? authApiModel;

  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    this.showMessage,
    this.authApiModel,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      showMessage: false,
      authApiModel: null,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
    bool? showMessage,
    AuthApiModel? currentUser,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      showMessage: showMessage ?? this.showMessage,
      authApiModel: authApiModel ?? this.authApiModel,
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error, currentUser: $authApiModel)';
}
