import 'package:book_app/presintions/home/widjets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../bloc/library/library_bloc.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {

  @override
  void initState() {
    context.read<LibraryBloc>().add(LoadBooksByAll());// TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LibraryBloc, LibraryState>(
      listener: (context, state) {
        if(state.allBooks.isEmpty) {
          print("Books list is empty");
        } else {
          print("Books list has data: ${state.allBooks.length} items");
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.arrow_back, color: Colors.black),
              title: Center(
                child: Text(
                  "Library",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              actions: [
                Icon(Icons.more_vert, color: Colors.black),
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Column(children: [
                  rowsHorizontal("Recently Played"),


                  if (state.allBooks.isEmpty)
                    const Center(child: CircularProgressIndicator())
                  else
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (_, i) {
                          // print("Separator builder reached");
                          return const SizedBox(width: 12.0);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: state.allBooks.length,
                        itemBuilder: (_, i) {
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: BookItem1(
                              path: state.allBooks[i].image,
                              onClick: () {
                                Navigator.pushNamed(
                                  context,
                                  '/play',
                                  arguments: state.allBooks[i],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                  rowsHorizontal("Playlists"),
                  const Text("No data available"),

                ],),
              ),
            )
        );
      },
    );
  }
}
