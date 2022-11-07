part of 'login_validation_bloc.dart';

enum AuthStatus { initial, success, failure }

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final AuthStatus authStatus;
  final String message;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.authStatus = AuthStatus.initial,
    this.message = "",
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    AuthStatus? authStatus,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      authStatus: authStatus ?? this.authStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [email, password, status, authStatus, message];
}
