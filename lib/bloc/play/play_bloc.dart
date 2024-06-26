import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(PlayState.initial()) {
    on<PlayFirstTimeEvent>((event, emit) async {
      await state.audioPlayer.setSourceUrl(event.url);
      await state.audioPlayer.resume();
      emit(state.copyWith(isPlaying: true, isFirstTime: false));
    });

    on<PlayAudioEvent>((event, emit) async {
      await state.audioPlayer.resume();
      emit(state.copyWith(isPlaying: true));
    });

    on<PauseAudioEvent>((event, emit) async {
      await state.audioPlayer.pause();
      emit(state.copyWith(isPlaying: false));
    });

    on<OpenPdfEvent>((event, emit) {
      emit(state.copyWith(isPlaying: false, toPdfScreen: true));
    });

    on<ForwardTenSecondsEvent>((event, emit) {
      var seconds = state.position.inSeconds + 10;
      emit(state.copyWith(position: Duration(seconds: seconds > state.duration.inSeconds ? state.position.inSeconds : seconds)));
    });

    on<BackwardTenSecondsEvent>((event, emit) {
      var seconds = state.position.inSeconds - 10;
      state.audioPlayer.seek(Duration(seconds: seconds < 0 ? 0 : seconds));
      emit(state);
    });

    on<OnPositionChangedEvent>((event, emit) {
      emit(state.copyWith(position: event.event));
    });

    on<OnDurationChangedEvent>((event, emit) {
      emit(state.copyWith(duration: event.event));
    });

    on<OnUserChangePositionEvent>((event, emit) {
      state.audioPlayer.seek(event.position);
      state.audioPlayer.resume();
      emit(state.copyWith(position: state.position));
    });

    on<ToPdfScreenEvent>((event, emit) {
      emit(state.copyWith(
        audioPlayer: state.audioPlayer..pause(),
        toPdfScreen: false,
      ));
      add(PauseAudioEvent());
    });

    on<DisposeAudioEvent>((event, emit) async {
      await state.audioPlayer.release();
      await state.audioPlayer.stop();
      await state.audioPlayer.dispose();

      emit(state.copyWith());
    });
  }
}
