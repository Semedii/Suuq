class SignupState {
  final String fullName;
  final String email;
  final String password;
  final String rePassword;
  final bool isAgreed;
  final bool isButtonLoading;

  SignupState({
    this.fullName = "",
    this.email = "",
    this.password = "",
    this.rePassword = "",
    this.isAgreed = false,
    this.isButtonLoading = false,
  });

  SignupState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? rePassword,
    bool? isAgreed,
    bool? isButtonLoading,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      isAgreed: isAgreed ?? this.isAgreed,
      isButtonLoading: isButtonLoading ?? this.isButtonLoading,
    );
  }
}
