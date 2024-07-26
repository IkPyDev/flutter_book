part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBooksByCategory extends HomeEvent {
  final String category;

  LoadBooksByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class LoadBooksByAll extends HomeEvent {
  final List<BookData> all;

  LoadBooksByAll(this.all);

  @override
  List<Object> get props => [all];
}

class LoadCategories extends HomeEvent {
  @override
  List<Object> get props => [];
}
