part of 'main_bloc.dart';

class MainState extends Equatable {
  final int screenIndex;

  const MainState({required this.screenIndex});

  factory MainState.initial() {
    return const MainState(screenIndex: 0);
  }

  MainState copyWith({int? screenIndex}) {
    return MainState(screenIndex: screenIndex ?? this.screenIndex);
  }

  @override
  List<Object> get props => [screenIndex];

  @override
  String toString() => 'MainState(screenIndex: $screenIndex)';
}
