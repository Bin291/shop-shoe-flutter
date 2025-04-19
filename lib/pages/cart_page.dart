import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../responsive/responsive_layout.dart';
import '../widgets/cart_item.dart';
import '../providers/shoe_provider.dart';
import 'home_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // Build the main body content for all layouts
  Widget _buildBody(BuildContext context, int crossAxisCount, double childAspectRatio) {
    final provider = Provider.of<ShoeProvider>(context);
    double subtotal = provider.cartItems.fold(0, (sum, item) => sum + (item.shoe.price * item.quantity));
    double shipping = 48.0;
    double total = subtotal + shipping;

    return Container(
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
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: provider.cartItems.length,
              itemBuilder: (context, index) => CartItemWidget(cartItem: provider.cartItems[index], onRemove: () {  },),
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
      title: Text('${Provider.of<ShoeProvider>(context).cartItems.length} Items', style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.ellipsis, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  // Mobile Layout
  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(context),
      body: _buildBody(context, 1, 3.0), // 1 column for mobile
    );
  }

  // Tablet Layout
  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(context),
      body: _buildBody(context, 2, 2.5), // 2 columns for tablet
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
                  onTap: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: _buildAppBar(context),
              body: _buildBody(context, 3, 2.0), // 3 columns for desktop
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
}