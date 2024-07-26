import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/search/search_bloc.dart';


class Search extends StatelessWidget {
  Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 36),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextField(
                      onChanged: (value) {
                        context.read<SearchBloc>().add(SearchBooks(value: value));
                      },
                      decoration: InputDecoration(
                        hintText: 'search books',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFF26B6C), width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: state.list!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/book',
                            arguments: state.list![index],
                          );
                        },
                        child: Container(
                          width: double.maxFinite,
                          color: Colors.white,
                          child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  state.list![index].image,
                                  width: double.maxFinite,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                          ),
                        ),
                      );
                    },
                  )
                ],
              )
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
