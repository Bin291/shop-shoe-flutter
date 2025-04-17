import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shoe_provider.dart';
import '../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoeProvider>(context);
    double subtotal = provider.cartItems.fold(0, (sum, item) => sum + (item.shoe.price * item.quantity));
    double shipping = 48.0;
    double total = subtotal + shipping;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('${provider.cartItems.length} Items', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.ellipsis, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.grey[900]!,
              Color(0xFF2F4F4F), // Moss green
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: provider.cartItems.length,
                itemBuilder: (context, index) => CartItemWidget(cartItem: provider.cartItems[index]),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: TextStyle(color: Colors.white)),
                      Text('\$${subtotal.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping', style: TextStyle(color: Colors.white)),
                      Text('\$${shipping.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total amount', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text('\$${total.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Checkout', style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}