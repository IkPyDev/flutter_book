import 'package:book_app/domain/main_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/book_data.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final _mainRepository = MainRepository();

  SearchBloc() : super(SearchState(list: [])) {
    on<GetAllBooksS>((event, emit) async {
      var ls = await _mainRepository.getAllBooks();
      emit(state.copyOf(list: ls));
    });

    on<SearchBooks>((event, emit) async {
      var ls = await _mainRepository.getAllBooks();
      ls.where((element) => element.name.toLowerCase().contains(event.value.toLowerCase())).toList();
      emit(state.copyOf(list: ls));
    });
  }
}
