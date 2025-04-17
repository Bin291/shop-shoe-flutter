import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shoe_model.dart';
import '../providers/shoe_provider.dart';

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