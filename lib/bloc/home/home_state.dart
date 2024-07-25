part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String chosenCategory;
  final List<BookData> booksByCategory;
  final List<String> allCategories;
  final List<BookData> allBooks;


  const HomeState({
    required this.chosenCategory,
    required this.booksByCategory,
    required this.allCategories,
    required this.allBooks,
  });

  factory HomeState.initial() {
    return const HomeState(chosenCategory: '', booksByCategory: [], allCategories: [],allBooks: []);
  }

  @override
  List<Object> get props => [chosenCategory, booksByCategory,allBooks];

  HomeState copyWith({
    String? category,
    List<BookData>? booksByCategory,
    List<String>? allCategories,
    List<BookData>? allBooks,
  }) {
    return HomeState(
      chosenCategory: category ?? this.chosenCategory,
      booksByCategory: booksByCategory ?? this.booksByCategory,
      allCategories: allCategories ?? this.allCategories,
      allBooks: allBooks ?? this.allBooks,
    );
  }

  @override
  String toString() => 'HomeState(category: $chosenCategory, booksByCategory: $booksByCategory)';
}
