import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Models
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
  final List<ShoeColor> colors; // Updated to include a list of colors
  final String imageUrl;
  final double rating;
  bool isLiked;
  String selectedColor; // To track the currently selected color

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.colors,
    required this.imageUrl,
    required this.rating,
    this.isLiked = false,
    required this.selectedColor, // Initialize with a default color
  });
}

class CartItem {
  final Shoe shoe;
  int quantity;
  int size;
  String color; // Add color to cart item

  CartItem({required this.shoe, this.quantity = 1, this.size = 40, required this.color});
}

// Provider for state management
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
      imageUrl: 'https://thumbs.dreamstime.com/b/dynamic-studio-shot-puma-sneakers-suspended-against-black-background-highlighting-their-sleek-navy-blue-design-white-324905434.jpg',
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

// Widgets
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

class CartItemWidget extends StatelessWidget {
  final CartItem  cartItem;

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

// Pages
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Phuong Bin', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.bell, color: Colors.white),
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
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildFilterChip('All', provider.selectedBrand == 'All', provider),
                  _buildFilterChip('Adidas', provider.selectedBrand == 'Adidas', provider),
                  _buildFilterChip('Nike', provider.selectedBrand == 'Nike', provider),
                  _buildFilterChip('Puma', provider.selectedBrand == 'Puma', provider),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: provider.shoes.length,
                itemBuilder: (context, index) => ShoeCard(shoe: provider.shoes[index]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, ShoeProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => provider.setBrand(label),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.yellow : Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(color: isSelected ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
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
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: 'Cart'),

        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          }
        },
      ),
    );
  }
}

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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      widget.shoe.imageUrl,
                      width: double.infinity, // Full width
                      height: MediaQuery.of(context).size.height * 0.55, // ~55% of screen height
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.white),
                    ),
                  ),
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
                  ElevatedButton(
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
                  SizedBox(height: 16),
                ],
              ),
            ),
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

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoeProvider>(context);
    double subtotal = provider.cartItems.fold(0, (sum, item) => sum + (item.shoe.price * item.quantity));
    double shipping = 100000.10;
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

// Main App
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        final provider = ShoeProvider();
        provider.loadCart();
        return provider;
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: HomePage(),
    );
  }
}