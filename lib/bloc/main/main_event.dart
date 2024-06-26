part of 'main_bloc.dart';

sealed class MainEvent {}

class MainChangeScreenEvent extends MainEvent {
  final int screenIndex;

  MainChangeScreenEvent({required this.screenIndex});
}
