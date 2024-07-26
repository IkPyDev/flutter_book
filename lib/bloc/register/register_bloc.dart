import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/registration_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _authRepository = RegistrationRepository.init();

  RegisterBloc() : super(RegisterState.initial()) {
    on<EmailChangeRegisterEvent>(_emailChange);
    on<PasswordChangeRegisterEvent>(_passwordChange);
    on<RetypePasswordChangeRegisterEvent>(_retypePasswordChange);
    on<RegisterWithEmailEvent>(_registerWithEmail);
    on<RegisterWithGoogleEvent>((event, emit) {});
    on<RegisterWithFacebookEvent>((event, emit) {});
    on<ToLoginClickEvent>((event, emit) {});
  }

  FutureOr<void> _emailChange(EmailChangeRegisterEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _passwordChange(PasswordChangeRegisterEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _retypePasswordChange(RetypePasswordChangeRegisterEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(retypePassword: event.retypePassword));
  }

  FutureOr<void> _registerWithEmail(RegisterWithEmailEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(registerState: RegisterEnum.loading));
    if (state.password != state.retypePassword) {
      emit(state.copyWith(registerState: RegisterEnum.error, errorMessage: 'Password and retype password not match'));
    }else {
      _authRepository.registerUser(state.email, state.password).then((value) {
      emit(state.copyWith(registerState: RegisterEnum.success));
    }).catchError((error) {
      emit(state.copyWith(registerState: RegisterEnum.error, errorMessage: error.toString()));
    });
    }
  }
}
