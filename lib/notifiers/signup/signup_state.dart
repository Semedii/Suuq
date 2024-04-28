class SignupState {
  final String fullName;
  final String email;
  final String password;
  final String rePassword;
  final bool isPasswordHidden;
  final bool isRePasswordHidden;
  final bool isAgreed;
  final bool isButtonLoading;

  SignupState({
    this.fullName = "",
    this.email = "",
    this.password = "",
    this.rePassword = "",
    this.isPasswordHidden = true,
    this.isRePasswordHidden = true,
    this.isAgreed = false,
    this.isButtonLoading = false,
  });

  SignupState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? rePassword,
    bool? isPasswordHidden,
    bool? isRePasswordHidden,
    bool? isAgreed,
    bool? isButtonLoading,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isRePasswordHidden: isRePasswordHidden ?? this.isRePasswordHidden,
      isAgreed: isAgreed ?? this.isAgreed,
      isButtonLoading: isButtonLoading ?? this.isButtonLoading,
    );
  }
}
