part of 'search_bloc.dart';

sealed class SearchEvent {}

class GetAllBooksS extends SearchEvent {}

class SearchBooks extends SearchEvent {
  String value;
  SearchBooks({required this.value});
}