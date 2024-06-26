part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginWithEmailEvent extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailEvent({required this.email, required this.password});
}

class LoginWithGoogleEvent extends LoginEvent {}

class LoginWithFacebookEvent extends LoginEvent{}

class SignInClickEvent extends LoginEvent {}

class ToRegisterClickEvent extends LoginEvent {}

class ForgetPasswordClickEvent extends LoginEvent {}

