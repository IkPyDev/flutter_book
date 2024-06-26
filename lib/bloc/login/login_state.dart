part of 'login_bloc.dart';

enum LoginEnum {
  initial,
  error,
  loading,
  success,
}

class LoginState extends Equatable {
  final LoginEnum loginState;

  factory LoginState.initial() {
    return const LoginState(loginState: LoginEnum.initial);
  }

  const LoginState({required this.loginState});

  @override
  List<Object?> get props => [loginState];

  LoginState copyWith({LoginEnum? loginState}) {
    return LoginState(loginState: loginState ?? this.loginState);
  }
}
