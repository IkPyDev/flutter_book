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
      final categories = await _mainRepository.getCategories();
      final allBooks = await _mainRepository.getAllBooks();
      emit(state.copyWith(
        allCategories: ['Hammasi', ...categories],
        allBooks: allBooks,
        booksByCategory: allBooks, // Initially display all books
      ));
    });

    on<LoadBooksByCategory>((event, emit) async {
      if (event.category == 'Hammasi') {
        emit(state.copyWith(chosenCategory: event.category, booksByCategory: state.allBooks));
      } else {
        emit(state.copyWith(
          chosenCategory: event.category,
          booksByCategory: state.allBooks.where((book) => book.category == event.category).toList(),
        ));
      }
    });

    on<LoadBooksByAll>((event, emit) async {
      final allBooks = await _mainRepository.getAllBooks();
      emit(state.copyWith(allBooks: allBooks));
    });
  }
}
