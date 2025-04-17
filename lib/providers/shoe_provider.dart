import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../main.dart';

class ShoeProvider with ChangeNotifier {
  final List<Shoe> _shoes = [
    Shoe(
      id: '1',
      name: 'Air Jordan Shoes',
      brand: 'Nike',
      price: 150.0,
      colors: [
        ShoeColor(name: 'Red', color: Colors.red),
        ShoeColor(name: 'Teal', color: Colors.teal),
        ShoeColor(name: 'Yellow', color: Colors.yellow),
      ],
      imageUrl: 'https://i.pinimg.com/736x/37/cd/93/37cd9342417c0c486ae065bb5f6ebf82.jpg',
      rating: 4.5,
      selectedColor: 'Red',
    ),
    Shoe(
      id: '2',
      name: 'Air Max 97',
      brand: 'Nike',
      price: 170.0,
      colors: [
        ShoeColor(name: 'Black', color: Colors.black),
        ShoeColor(name: 'White', color: Colors.white),
        ShoeColor(name: 'Blue', color: Colors.blue),
      ],
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpMedpdAJ9Y06MVXbjD53uIUSHBeNC-qF0-A&s',
      rating: 4.7,
      selectedColor: 'Black',
    ),
    Shoe(
      id: '3',
      name: 'React Infinity',
      brand: 'Nike',
      price: 160.0,
      colors: [
        ShoeColor(name: 'Red', color: Colors.red),
        ShoeColor(name: 'Green', color: Colors.green),
        ShoeColor(name: 'Yellow', color: Colors.yellow),
      ],
      imageUrl: 'https://i.pinimg.com/originals/c2/ed/b3/c2edb359d7856a59bc9e696fd310933d.jpg',
      rating: 4.6,
      selectedColor: 'Red',
    ),
    Shoe(
      id: '4',
      name: 'PUMA MAX 90-EZ',
      brand: 'Puma',
      price: 140.0,
      colors: [
        ShoeColor(name: 'Yellow', color: Colors.yellow),
        ShoeColor(name: 'Red', color: Colors.red),
        ShoeColor(name: 'Blue', color: Colors.blue),
      ],
      imageUrl: 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHVtYSUyMHNob2VzfGVufDB8fDB8fHww',
      rating: 4.5,
      selectedColor: 'Yellow',
    ),
    Shoe(
      id: '5',
      name: 'PUMA RS-X',
      brand: 'Puma',
      price: 130.0,
      colors: [
        ShoeColor(name: 'Red', color: Colors.red),
        ShoeColor(name: 'Black', color: Colors.black),
        ShoeColor(name: 'White', color: Colors.white),
      ],
      imageUrl: 'https://thumbs.dreamstime.com/b/two-black-adidas-shoes-shown-mirror-white-have-shiny-appearance-370648034.jpg',
      rating: 4.4,
      selectedColor: 'Red',
    ),
    Shoe(
      id: '6',
      name: 'PUMA Suede',
      brand: 'Puma',
      price: 120.0,
      colors: [
        ShoeColor(name: 'Green', color: Colors.green),
        ShoeColor(name: 'Brown', color: Colors.brown),
        ShoeColor(name: 'Black', color: Colors.black),
      ],
      imageUrl: 'https://thumbs.dreamstime.com/b/two-black-adidas-shoes-shown-mirror-white-have-shiny-appearance-370648034.jpg',
      rating: 4.3,
      selectedColor: 'Green',
    ),
    Shoe(
      id: '7',
      name: 'Ultra-boost 21',
      brand: 'Adidas',
      price: 180.0,
      colors: [
        ShoeColor(name: 'Black', color: Colors.black),
        ShoeColor(name: 'White', color: Colors.white),
        ShoeColor(name: 'Blue', color: Colors.blue),
      ],
      imageUrl: 'https://t3.ftcdn.net/jpg/03/63/98/32/360_F_363983245_4icqrjbSqjPcnxF1onaNRQAW7MaSfurZ.jpg',
      rating: 4.8,
      selectedColor: 'Black',
    ),
    Shoe(
      id: '8',
      name: 'Yeezy Boost 350',
      brand: 'Adidas',
      price: 220.0,
      colors: [
        ShoeColor(name: 'Cream', color: Colors.white70),
        ShoeColor(name: 'Black', color: Colors.black),
        ShoeColor(name: 'Grey', color: Colors.grey),
      ],
      imageUrl: 'https://images3.alphacoders.com/133/thumb-350-1331553.webp',
      rating: 4.9,
      selectedColor: 'Cream',
    ),
    Shoe(
      id: '9',
      name: 'Stan Smith',
      brand: 'Adidas',
      price: 110.0,
      colors: [
        ShoeColor(name: 'White', color: Colors.white),
        ShoeColor(name: 'Green', color: Colors.green),
        ShoeColor(name: 'Black', color: Colors.black),
      ],
      imageUrl: 'https://images.unsplash.com/photo-1518002171953-a080ee817e1f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YWRpZGFzJTIwc2hvZXN8ZW58MHx8MHx8fDA%3D',
      rating: 4.2,
      selectedColor: 'White',
    ),
  ];

  List<CartItem> _cartItems = [];
  String _selectedBrand = 'All';

  List<Shoe> get shoes => _selectedBrand == 'All'
      ? _shoes
      : _shoes.where((shoe) => shoe.brand == _selectedBrand).toList();
  List<CartItem> get cartItems => _cartItems;
  String get selectedBrand => _selectedBrand;

  void setBrand(String brand) {
    _selectedBrand = brand;
    notifyListeners();
  }

  void toggleLike(Shoe shoe) {
    shoe.isLiked = !shoe.isLiked;
    notifyListeners();
  }

  void setColor(Shoe shoe, String color) {
    shoe.selectedColor = color;
    notifyListeners();
  }

  void addToCart(Shoe shoe, int size, String color) {
    final existingItem = _cartItems.firstWhere(
          (item) => item.shoe.id == shoe.id && item.size == size && item.color == color,
      orElse: () => CartItem(shoe: shoe, size: size, color: color),
    );

    if (_cartItems.contains(existingItem)) {
      existingItem.quantity++;
    } else {
      _cartItems.add(existingItem);
    }
    _saveCart();
    notifyListeners();
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity <= 0) {
      _cartItems.remove(item);
    } else {
      item.quantity = newQuantity;
    }
    _saveCart();
    notifyListeners();
  }
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = _cartItems.map((item) => '${item.shoe.id}:${item.quantity}:${item.size}:${item.color}').join(',');
    await prefs.setString('cart', cartData);
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart') ?? '';
    if (cartData.isNotEmpty) {
      _cartItems = cartData.split(',').map((data) {
        final parts = data.split(':');
        final shoe = _shoes.firstWhere((s) => s.id == parts[0]);
        return CartItem(
          shoe: shoe,
          quantity: int.parse(parts[1]),
          size: int.parse(parts[2]),
          color: parts[3],
        );
      }).toList();
      notifyListeners();
    }
  }
}