import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/responsive/responsive_layout.dart';
import 'pages/home_page.dart';
import 'providers/shoe_provider.dart';

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
      home: const ResponsiveLayout(
        mobileLayout: HomePage(),
        tabletLayout: HomePage(),
        desktopLayout: HomePage(),
      ),
    );
  }
}