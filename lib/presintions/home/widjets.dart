
import 'package:flutter/material.dart';

Widget rowsHorizontal(String name){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: const TextStyle(
          color: Color(0xFF4F4F4F),
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      const Text(
        "See all",
        style: TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
      ),
    ],
  );
}

Widget myWidget(BuildContext context) {
  return MediaQuery.removePadding(
    context: context,
    child: GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.amber,
          child: Center(child: Text('$index')),
        );
      },
    ),
  );
}

Widget myHorizontallScroll(BuildContext context) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemBuilder: (c, i) {
      return Container(
        height: 170,
        width: 100,
        child: Card(
          color: Colors.amber,
          child: Center(child: Text('$i')),
        ),
      );
    },
    separatorBuilder: (_, __) {
      return const SizedBox(width: 10);
    },
    itemCount: 7,
  );
}


final colorList = [
  (const Color(0xffead4d4), Colors.red), // Lighter red
  (const Color(0xffeef6e0), Colors.green), // Lighter green
  (const Color(0xff64ade8), Colors.blue), // Original blue
  (const Color(0xffeedd9d), Colors.yellow), // Original yellow
  (const Color(0xffc695e3), Colors.purple), // Original purple
  (const Color(0xffe1be9a), Colors.orange), // Original orange
  (const Color(0xffe7b1c8), Colors.pink), // Original pink
  (const Color(0xffc9e1c0), Colors.teal), // Original teal
  (const Color(0xffe1e5f8), Colors.indigo), // Original indigo
];

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.colorIndex,
    required this.category,
    required this.onClick,
    this.isChosen = false,
  });

  final int colorIndex;
  final String category;
  final VoidCallback onClick;
  final bool isChosen;

  @override
  Widget build(BuildContext context) {
    int colorIndex = this.colorIndex;

    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        height: 64,
        width: 132,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isChosen ? colorList[colorIndex % 9].$2 : colorList[colorIndex % 9].$1,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          category,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isChosen ? Colors.white : colorList[colorIndex % 9].$2,
          ),
        ),
      ),
    );
  }
}


class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.path, required this.onClick});

  final String path;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              path,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
      ),
    );
  }
}

class BookItem1  extends StatelessWidget {
  const BookItem1 ({super.key, required this.path, required this.onClick});

  final String path;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 250,
        width: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              path,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
      ),
    );
  }
}

