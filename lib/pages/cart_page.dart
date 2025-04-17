import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
// import '../providers/shoe_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoeProvider>(context);
    double subtotal = provider.cartItems.fold(0, (sum, item) => sum + (item.shoe.price * item.quantity));
    double shipping = 10.0; // Example shipping cost
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
              Color(0xFF2F4F4F),
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
                    onPressed: () {
                      // Handle checkout logic
                    },
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

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoeProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.network(
            cartItem.shoe.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.white),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.shoe.name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text('Color: ${cartItem.color}', style: TextStyle(color: Colors.grey, fontSize: 14)),
                Text('\$${cartItem.shoe.price}', style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => provider.updateQuantity(cartItem, cartItem.quantity - 1),
                icon: Icon(CupertinoIcons.minus, color: Colors.white),
              ),
              Text('${cartItem.quantity}', style: TextStyle(color: Colors.white)),
              IconButton(
                onPressed: () => provider.updateQuantity(cartItem, cartItem.quantity + 1),
                icon: Icon(CupertinoIcons.plus, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}