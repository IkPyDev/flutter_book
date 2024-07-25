import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/registration_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final _authRepository = RegistrationRepository.init();

  LoginBloc() : super(LoginState.initial()) {
    on<LoginWithEmailEvent>((event, emit) async {
      await _authRepository.loginUser(event.email, event.password).then((value) {
        if (value == null) {
          emit(state.copyWith(loginState: LoginEnum.success));
          print("AAAAAAAAAAAAAA");

        } else {
          print("HHHHHHH");
          emit(state.copyWith(loginState: LoginEnum.error,));
        }
      });
    });
    on<LoginWithGoogleEvent>((event, emit) {});
    on<LoginWithFacebookEvent>((event, emit) {});
    on<SignInClickEvent>((event, emit) {});
    on<ToRegisterClickEvent>((event, emit) {});
    on<ForgetPasswordClickEvent>((event, emit) {});
  }
}
