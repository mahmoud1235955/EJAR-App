import 'package:flutter/material.dart';

import '../../../constants/extentions.dart';
class ListviewSeperatedWidget extends StatelessWidget {
  final String imageUrl;
  final String ProductName;
  final int numberOfItems;
  const ListviewSeperatedWidget({
    super.key,
    required this.imageUrl,
    required this.ProductName,
    required this.numberOfItems,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) {
        return Stack(
          children: [
            Container(
              color: Colors.grey[300],
              width: 200,
              height: 100,
              child: Center(child: Image.network(imageUrl, fit: BoxFit.cover)),
            ),
            10.gap,
            Text(
              ProductName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
      separatorBuilder: (_, _) {
        return 10.gap;
      },
      itemCount: numberOfItems,
    );
  }
}
