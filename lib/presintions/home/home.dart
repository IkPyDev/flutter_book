import 'package:book_app/presintions/home/widjets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/home/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.allBooks.isEmpty) {
          print("Books list is empty");
        } else {
          print("Books list has data: ${state.allBooks.length} items");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  Navigator.pushNamed(context, '/search');
                },
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            centerTitle: true,
            title: Text(
              'Explore',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowsHorizontal("All Books"),
                  const SizedBox(height: 12.0),
                  if (state.allBooks.isEmpty)
                  // Shimmer effect for loading state
                    Column(
                      children: [
                        Row(
                          children: List.generate(
                            2,
                                (index) => Padding(
                              padding: const EdgeInsets.all(12),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 250,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (_, i) {
                          print("Separator builder reached");
                          return const SizedBox(width: 12.0);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: state.allBooks.length,
                        itemBuilder: (_, i) {
                          print("Building item ${i}");
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
                  const SizedBox(height: 12.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < state.allCategories.length; ++i)
                          CategoryItem(
                            colorIndex: i,
                            category: state.allCategories[i],
                            onClick: () {
                              context.read<HomeBloc>().add(
                                  LoadBooksByCategory(state.allCategories[i]));
                            },
                            isChosen:
                            state.allCategories[i] == state.chosenCategory,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Expanded(
                    child: state.booksByCategory.isEmpty
                        ? GridView.builder(
                      itemCount: 6, // Number of shimmer items
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3 / 5,
                      ),
                      itemBuilder: (_, i) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                        : GridView.builder(
                      itemCount: state.booksByCategory.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3 / 5,
                      ),
                      itemBuilder: (_, i) => BookItem(
                        path: state.booksByCategory[i].image,
                        onClick: () {
                          Navigator.pushNamed(
                            context,
                            '/play',
                            arguments: state.booksByCategory[i],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
