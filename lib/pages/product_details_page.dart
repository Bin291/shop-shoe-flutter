import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shoe_model.dart';
import '../providers/shoe_provider.dart';
import '../responsive/responsive_layout.dart';
import 'cart_page.dart';
import 'home_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Shoe shoe;

  const ProductDetailPage({super.key, required this.shoe});

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

  // Build the main body content for all layouts
  Widget _buildBody(BuildContext context, double imageAspectRatio) {
    final provider = Provider.of<ShoeProvider>(context, listen: false);
    return Container(
      width: double.infinity,
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: imageAspectRatio,
              child: Image.network(
                widget.shoe.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
                    width: double.infinity,
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
    );
  }

  // AppBar for all layouts
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  // Mobile Layout
  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(context),
      body: _buildBody(context, 1.5), // Mobile image aspect ratio
    );
  }

  // Tablet Layout
  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(context),
      body: _buildBody(context, 1.8), // Tablet image aspect ratio
    );
  }

  // Desktop Layout
  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Container(
            width: 200,
            color: Colors.grey[900],
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.grey[900]!],
                    ),
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text('Home', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart, color: Colors.white),
                  title: Text('Cart', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: _buildAppBar(context),
              body: _buildBody(context, 2.0), // Desktop image aspect ratio
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLayout: _buildMobileLayout(context),
      tabletLayout: _buildTabletLayout(context),
      desktopLayout: _buildDesktopLayout(context),
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