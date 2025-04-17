import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shoe_model.dart';
import '../providers/shoe_provider.dart';
import 'cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Shoe shoe;

  const ProductDetailPage({required this.shoe});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedSize = 40;
  int quantity = 1;
  late String selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.shoe.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.cart, color: Colors.white),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage())),
          ),
        ],
      ),
      body: Container(
        width: double.infinity, // Ensure the container takes full width
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.shoe.imageUrl,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.55,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16), // Only horizontal padding to maintain some spacing on sides
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(widget.shoe.name, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 16),
                        SizedBox(width: 4),
                        Text('${widget.shoe.rating} (862)', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Description',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Air Jordan is a line of basketball shoes and athletic apparel produced by Nike. The brand was created for and endorsed by Michael Jordan, the legendary...',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    Text('Color', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: widget.shoe.colors.map((shoeColor) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = shoeColor.name;
                                provider.setColor(widget.shoe, selectedColor);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedColor == shoeColor.name ? Colors.yellow : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: shoeColor.color,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Text('Size', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        _buildSizeButton('38', 38),
                        _buildSizeButton('39', 39),
                        _buildSizeButton('40', 40),
                        _buildSizeButton('41', 41),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${widget.shoe.price}', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) quantity--;
                                });
                              },
                              icon: Icon(CupertinoIcons.minus, color: Colors.white),
                            ),
                            Text('$quantity', style: TextStyle(color: Colors.white)),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: Icon(CupertinoIcons.plus, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity, // Ensure button takes full width
                      child: ElevatedButton(
                        onPressed: () {
                          provider.addToCart(widget.shoe, selectedSize, selectedColor);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to cart')));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Add to cart', style: TextStyle(color: Colors.black, fontSize: 16)),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSizeButton(String size, int sizeValue) {
    bool isSelected = selectedSize == sizeValue;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedSize = sizeValue;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.yellow : Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            size,
            style: TextStyle(color: isSelected ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}