part of 'register_bloc.dart';

enum RegisterEnum {
  initial,
  error,
  loading,
  success,
}

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String retypePassword;
  final String errorMessage;
  final RegisterEnum registerState;

  factory RegisterState.initial() {
    return RegisterState(
      email: '',
      password: '',
      retypePassword: '',
      errorMessage: '',
      registerState: RegisterEnum.initial,
    );
  }

  const RegisterState({
    required this.email,
    required this.password,
    required this.retypePassword,
    required this.errorMessage,
    required this.registerState,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? retypePassword,
    String? errorMessage,
    RegisterEnum? registerState,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      retypePassword: retypePassword ?? this.retypePassword,
      errorMessage: errorMessage ?? this.errorMessage,
      registerState: registerState ?? this.registerState,
    );
  }

  @override
  List<Object?> get props => [email, password, retypePassword, errorMessage, registerState];
}
