part of 'login_bloc.dart';

enum LoginEnum {
  initial,
  error,
  loading,
  success,
}

class LoginState extends Equatable {
    String email = '';
    String password = '';
    String errorMessage = '';
   LoginEnum loginState;

  factory LoginState.initial() {
    return  LoginState(loginState: LoginEnum.initial);
  }

   LoginState({required this.loginState,this.email = '',this.password = '',this.errorMessage = ''});


 LoginState copyWith({
    String? email,
    String? password,
    String? errorMessage,
    LoginEnum? loginState,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loginState: loginState ?? this.loginState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }


  @override
  String toString() => 'LoginState(loginState: $loginState email: $email password: $password)';


    @override
    List<Object?> get props => [loginState,email,password,errorMessage];
}
