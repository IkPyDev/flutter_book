part of 'search_bloc.dart';

class SearchState {
  List<BookData>? list;

  SearchState({
    required this.list
  });

  SearchState copyOf({List<BookData>? list}) {
    return SearchState(
        list: list ?? this.list
    );
  }
}

