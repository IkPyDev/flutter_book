import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/registration_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _authRepository = RegistrationRepository.init();

  LoginBloc() : super(LoginState(loginState: LoginEnum.initial)) {
    on<EmailChangeLoginEvent>(_emailChange);
    on<PasswordChangeLoginEvent>(_passwordChange);
    on<LoginWithEmailEvent>(_loginWithEmail);
    on<LoginWithGoogleEvent>((event, emit) {});
    on<LoginWithFacebookEvent>((event, emit) {});
    on<SignInClickEvent>((event, emit) {});
    on<ToRegisterClickEvent>((event, emit) {});
    on<ForgetPasswordClickEvent>((event, emit) {});
  }

  FutureOr<void> _emailChange(EmailChangeLoginEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _passwordChange(PasswordChangeLoginEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _loginWithEmail(LoginWithEmailEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginState: LoginEnum.loading));
    if (state.email.trim().isNotEmpty && state.password.trim().isNotEmpty) {
      emit(state.copyWith(loginState: LoginEnum.error, errorMessage: 'Email and password must not be empty'));
      return;
    }
    try {
      await _authRepository.loginUser(state.email.trim(), state.password.trim());
      emit(state.copyWith(loginState: LoginEnum.success));
    } catch (error) {
      emit(state.copyWith(loginState: LoginEnum.error, errorMessage: error.toString()));
    }
  }
}
