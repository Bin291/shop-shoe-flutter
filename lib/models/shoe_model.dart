import 'package:flutter/material.dart';

class ShoeColor {
  final String name;
  final Color color;

  ShoeColor({required this.name, required this.color});
}

class Shoe {
  final String id;
  final String name;
  final String brand;
  final double price;
  final List<ShoeColor> colors;
  final String imageUrl;
  final double rating;
  bool isLiked;
  String selectedColor;

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.colors,
    required this.imageUrl,
    required this.rating,
    this.isLiked = false,
    required this.selectedColor,
  });
}

class CartItem {
  final Shoe shoe;
  int quantity;
  int size;
  String color;

  CartItem({required this.shoe, this.quantity = 1, this.size = 40, required this.color});
}