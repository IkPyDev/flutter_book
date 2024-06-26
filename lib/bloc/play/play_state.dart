part of 'play_bloc.dart';

class PlayState extends Equatable {
  final AudioPlayer audioPlayer;
  final bool isPlaying;
  final bool toPdfScreen;
  final Duration duration;
  final Duration position;
  final bool isFirstTime;

  factory PlayState.initial() {
    return PlayState(
      audioPlayer: AudioPlayer(),
      duration: const Duration(),
      isPlaying: true,
      position: const Duration(),
      toPdfScreen: false,
      isFirstTime: true,
    );
  }

  const PlayState({
    required this.audioPlayer,
    required this.isPlaying,
    required this.toPdfScreen,
    required this.duration,
    required this.position,
    required this.isFirstTime,
  });

  PlayState copyWith({
    AudioPlayer? audioPlayer,
    bool? isPlaying,
    bool? toPdfScreen,
    Duration? duration,
    Duration? position,
    bool? isFirstTime,
  }) {
    return PlayState(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isPlaying: isPlaying ?? this.isPlaying,
      toPdfScreen: toPdfScreen ?? this.toPdfScreen,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }

  @override
  String toString() {
    return 'PlayState(audioPlayer: $audioPlayer, isPlaying: $isPlaying, toPdfScreen: $toPdfScreen, duration: $duration, position: $position, isFirstTime: $isFirstTime)';
  }

  @override
  List<Object> get props {
    return [
      audioPlayer,
      isPlaying,
      toPdfScreen,
      duration,
      position,
      isFirstTime,
    ];
  }
}
