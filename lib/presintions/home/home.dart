import 'package:book_app/presintions/home/widjets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/home/home_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
            automaticallyImplyLeading: false,

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
            // leading: IconButton(
            //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
            //   onPressed: () {
            //     Scaffold.of(context).openDrawer();
            //   },
            // ),
            centerTitle: true,
            title: Text(
              'Explore',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowsHorizontal("All Books"),
                  AllBooksRow(),
                  SizedBox(height: 12.0),
                  CategoriesRow(),
                  SizedBox(height: 24.0),
                  BooksByCategoryGrid(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AllBooksRow extends StatelessWidget {
  const AllBooksRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.allBooks.isEmpty) {
          return const ShimmerLoadingRow();
        } else {
          return SizedBox(
            height: 200,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, i) {
                return const SizedBox(width: 12.0);
              },
              scrollDirection: Axis.horizontal,
              itemCount: state.allBooks.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Hero(
                    tag: state.allBooks[i].audio,
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
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

class ShimmerLoadingRow extends StatelessWidget {
  const ShimmerLoadingRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: List.generate(
              2,
              (index) => Padding(
                padding: const EdgeInsets.all(3),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 200,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.allCategories.isNotEmpty) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < state.allCategories.length; ++i)
                  CategoryItem(
                    colorIndex: i,
                    category: state.allCategories[i],
                    onClick: () {
                      context.read<HomeBloc>().add(LoadBooksByCategory(state.allCategories[i]));
                    },
                    isChosen: state.allCategories[i] == state.chosenCategory,
                  ),
              ],
            ),
          );
        } else {
          return const ShimmerLoadingCategories();
        }
      },
    );
  }
}

class ShimmerLoadingCategories extends StatelessWidget {
  const ShimmerLoadingCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            2,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 64,
                      width: 132,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}

class BooksByCategoryGrid extends StatelessWidget {
  const BooksByCategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.booksByCategory.isEmpty) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          );
        } else {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.booksByCategory.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3 / 5,
            ),
            itemBuilder: (_, i) {
              print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
              print(state.booksByCategory[i].audio);
              return Hero(
                tag:"HHHH",
                child: BookItem(
                  path: state.booksByCategory[i].image,
                  onClick: () {
                    Navigator.pushNamed(
                      context,
                      '/play',
                      arguments: state.booksByCategory[i],
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
