part of 'library_bloc.dart';



class LibraryState extends Equatable {
  final List<BookData> allBooks;

  const LibraryState({
    required this.allBooks,
  });

  factory LibraryState.initial() {
    return const LibraryState(allBooks: []);
  }

  @override
  List<Object> get props => [allBooks];

  LibraryState copyWith({
    List<BookData>? allBooks,
  }) {
    return LibraryState(
      allBooks: allBooks ?? this.allBooks,
    );
  }


}

