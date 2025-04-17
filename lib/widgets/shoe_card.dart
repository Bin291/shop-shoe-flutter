import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shoe_model.dart';
import '../pages/product_details_page.dart';
import '../providers/shoe_provider.dart';

class ShoeCard extends StatelessWidget {
  final Shoe shoe;

  const ShoeCard({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoeProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailPage(shoe: shoe)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                shoe.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            Text(
              shoe.name,
              style: TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            SizedBox(height: 4),
            Row(
              children: List.generate(
                5,
                    (index) => Icon(
                  index < shoe.rating.floor() ? CupertinoIcons.star_fill : CupertinoIcons.star,
                  color: Colors.yellow,
                  size: 14,
                ),
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${shoe.price}',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => provider.toggleLike(shoe),
                  icon: Icon(
                    shoe.isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    color: shoe.isLiked ? Colors.yellow : Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}