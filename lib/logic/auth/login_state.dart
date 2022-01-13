class LoginState {
  final String username;
  final String password;
  final bool isValidLogin;

  LoginState({
    this.username = '',
    this.password = '',
    this.isValidLogin = false,
  });

  LoginState copyWith({
    String? username,
    String? password,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
