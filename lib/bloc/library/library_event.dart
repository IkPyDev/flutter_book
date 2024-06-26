part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent {}

class LibraryInitial extends LibraryEvent {}

class LoadBooksByAll extends LibraryEvent {
}

