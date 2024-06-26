import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/main_repository.dart';
import '../../domain/model/book_data.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final _mainRepository = MainRepository();

  LibraryBloc() : super(LibraryState.initial()) {
    on<LoadBooksByAll>((event, emit) async {
      final allBooks = await _mainRepository.getAllBooks();
      // reverse
      emit(state.copyWith(allBooks: allBooks.reversed.toList()));
    });

    // on<LoadBooksByAll>((event, emit) async {
    //   final allBooks = await _mainRepository.getAllBooks();
    //   emit(state.copyWith(allBooks:allBooks));
    //   print('Loaded all books: ${event.all.length}');
    // });

  }

}
