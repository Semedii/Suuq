class LoginState {
  final String email;
  final String password;
  final bool isPasswordHidden;

  LoginState({
    this.email = "",
    this.password = "",
    this.isPasswordHidden = true,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isPasswordHidden,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
    );
  }
}
