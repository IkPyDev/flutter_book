import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial()) {
    on<MainChangeScreenEvent>((event, emit) {
      emit(state.copyWith(screenIndex: event.screenIndex));
    });
  }
}
