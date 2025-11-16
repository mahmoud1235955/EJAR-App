// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../../constants/extentions.dart';
class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.itemCount,
    required this.scrollDirection,
    required this.img,
    required this.ProductName,
    required this.ProductPrice,
  });
  final int itemCount;
  final Axis scrollDirection;
  final String img;
  final String ProductName;
  final String ProductPrice;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            5.gap,
            Text(ProductName),
            5.gap,
            Text(ProductPrice),
          ],
        ),
      ),
    );
  }
}
