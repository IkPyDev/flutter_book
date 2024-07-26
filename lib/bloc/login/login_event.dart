part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginWithEmailEvent extends LoginEvent {
}

final class EmailChangeLoginEvent extends LoginEvent{
  final String email;

  EmailChangeLoginEvent(this.email);
}
final class PasswordChangeLoginEvent extends LoginEvent{
  final String password;

  PasswordChangeLoginEvent(this.password);
}
class LoginWithGoogleEvent extends LoginEvent {}

class LoginWithFacebookEvent extends LoginEvent{}

class SignInClickEvent extends LoginEvent {}

class ToRegisterClickEvent extends LoginEvent {}

class ForgetPasswordClickEvent extends LoginEvent {}

