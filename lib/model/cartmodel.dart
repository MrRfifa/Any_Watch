import 'package:flutter/material.dart';

class CartModel {
  final String name;
  final String image;
  final String type;
  final int quantity;
  final double price;
  CartModel({
    required this.image,
    required this.type,
    required this.name,
    required this.quantity,
    required this.price,
  });
}
