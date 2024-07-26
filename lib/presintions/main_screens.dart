import 'package:book_app/bloc/home/home_bloc.dart';
import 'package:book_app/bloc/library/library_bloc.dart';
import 'package:book_app/bloc/main/main_bloc.dart';
import 'package:book_app/presintions/home/detail/detail.dart';
import 'package:book_app/presintions/home/library/library.dart';
import 'package:book_app/presintions/home/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search/search_bloc.dart';
import 'home/home.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc,MainState>(listener: (c,s){

    },builder: (context,state){
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: state.screenIndex,
            children: [
              BlocProvider(create: (context) => HomeBloc()..add(LoadCategories()),
              child: const Home(),
              ),
              BlocProvider(create: (context) => SearchBloc(),
                child:  Search(),
              ),
              BlocProvider(create: (context) => LibraryBloc(),
                child: const Library(),
              ),
              const Detail(),

            ],
          ),
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
            child: const Icon(
              Icons.play_arrow,
              size: 42,
            ),
          ),
        ),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          color: Colors.white24,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildBottomNavigationItem(Icons.home, 'Home', 0, (int index) => _updateIndex(index, context), state.screenIndex),
              buildBottomNavigationItem(Icons.search, 'Search', 1, (int index) => _updateIndex(index, context), state.screenIndex),
              const SizedBox(width: 36),
              buildBottomNavigationItem(Icons.library_books, 'Library', 2, (int index) => _updateIndex(index, context), state.screenIndex),
              buildBottomNavigationItem(Icons.person, 'Profile', 3, (int index) => _updateIndex(index, context), state.screenIndex),
            ],
          ),
        ),
      );
    });
  }


}

_updateIndex(int index, BuildContext context) {
  context.read<MainBloc>().add(MainChangeScreenEvent(screenIndex: index));
}


Widget buildBottomNavigationItem(
    IconData icon,
    String label,
    int index,
    void Function(int index) onItemTapped,
    int selectedIndex,
    ) {
  return GestureDetector(
    onTap: () => onItemTapped(index),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 32,
          color: selectedIndex == index ? Colors.red : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            color: selectedIndex == index ? Colors.red : Colors.grey,
          ),
        ),
      ],
    ),
  );
}
