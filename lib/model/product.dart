import 'package:flutter/material.dart';

class Product {
  final String name;
  final String image;
  final String type;
  final int price;
  Product(
      {required this.image,
      required this.name,
      required this.type,
      required this.price});
}
