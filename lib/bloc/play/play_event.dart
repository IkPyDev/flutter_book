part of 'play_bloc.dart';

class PlayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PauseAudioEvent extends PlayEvent {}

class PlayAudioEvent extends PlayEvent {
  final String url;

  PlayAudioEvent({required this.url});

  @override
  String toString() => 'PlayAudioEvent(url: $url)';

  @override
  List<Object?> get props => [url];
}

class ForwardTenSecondsEvent extends PlayEvent {}

class BackwardTenSecondsEvent extends PlayEvent {}

class OpenPdfEvent extends PlayEvent {}

class OnPositionChangedEvent extends PlayEvent {
  final Duration event;

  OnPositionChangedEvent({required this.event});

  @override
  List<Object?> get props => [event];
}

class OnDurationChangedEvent extends PlayEvent {
  final Duration event;

  OnDurationChangedEvent({required this.event});

  @override
  List<Object?> get props => [event];
}

class PlayFirstTimeEvent extends PlayEvent {
  final String url;

  PlayFirstTimeEvent({required this.url});

  @override
  String toString() => 'PlayFirstTimeEvent(url: $url)';

  @override
  List<Object?> get props => [url];
}

class OnUserChangePositionEvent extends PlayEvent {
  final Duration position;

  OnUserChangePositionEvent({required this.position});

  @override
  List<Object?> get props => [position];
}

class ToPdfScreenEvent extends PlayEvent {}

class DisposeAudioEvent extends PlayEvent {}
