part of 'register_bloc.dart';


abstract class RegisterEvent {}

class RegisterWithEmailEvent extends RegisterEvent {
  final String email;
  final String password;
  final String retypePassword;

  RegisterWithEmailEvent(this.email, this.password, this.retypePassword);
}

class EmailChangeRegisterEvent extends RegisterEvent {
  final String email;

  EmailChangeRegisterEvent(this.email);
}

class PasswordChangeRegisterEvent extends RegisterEvent {
  final String password;

  PasswordChangeRegisterEvent(this.password);
}

class RetypePasswordChangeRegisterEvent extends RegisterEvent {
  final String retypePassword;

  RetypePasswordChangeRegisterEvent(this.retypePassword);
}

class RegisterWithGoogleEvent extends RegisterEvent {}

class RegisterWithFacebookEvent extends RegisterEvent {}

class ToLoginClickEvent extends RegisterEvent {}

