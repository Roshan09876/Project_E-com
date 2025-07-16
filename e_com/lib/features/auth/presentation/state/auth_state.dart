import 'package:e_com/features/auth/data/model/auth_api_model.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final bool? showMessage;
  final AuthApiModel? profileData;

  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    this.showMessage,
    this.profileData,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      showMessage: false,
      profileData: null,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
    bool? showMessage,
    AuthApiModel? profileData,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      showMessage: showMessage ?? this.showMessage,
      profileData: profileData ?? this.profileData,
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error, currentUser: $profileData)';
}
