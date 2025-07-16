import 'package:e_com/features/auth/data/model/auth_api_model.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final bool? showMessage;
  final AuthApiModel? currentUser;

  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    this.showMessage,
     this.currentUser,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      showMessage: false,
      currentUser: null
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
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error, currentUser: $currentUser)';
}