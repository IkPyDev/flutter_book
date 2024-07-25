import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/main_repository.dart';
import '../../domain/model/book_data.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _mainRepository = MainRepository();

  HomeBloc() : super(HomeState.initial()) {
    on<LoadCategories>((event, emit) async {
      print("ZZZZZZZZZZZZZZZZZZZZZZZZZZz");

      final categories = await _mainRepository.getCategories();
      final allBooks = await _mainRepository.getAllBooks();
      print("XXXXXXXXXXXXXXXXXXXXXX");
      emit(state.copyWith(allCategories: categories, allBooks: allBooks,));

      if(allBooks.isNotEmpty) {
        print('all books: ${allBooks.length}' );
        add(LoadBooksByAll(allBooks));
      }

      if (categories.isNotEmpty) {
        add(LoadBooksByCategory(categories.first));
      }
    });

    on<LoadBooksByCategory>((event, emit) async {
      final books = await _mainRepository.getBooksByCategory(event.category);
      emit(state.copyWith(category: event.category, booksByCategory: books));
      print(
          ' category ${event.category}  books by category: ${state.booksByCategory.length}');
    });

    on<LoadBooksByAll>((event, emit) async {
      final allBooks = await _mainRepository.getAllBooks();
      emit(state.copyWith(allBooks:allBooks));
      print('Loaded all books: ${event.all.length}');
    });
  }
}
