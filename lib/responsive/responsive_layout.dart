import 'package:flutter/material.dart';

// Responsive layout widget that determines the layout based on screen width and device type
class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;

  const ResponsiveLayout({super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desktopLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortestSide = MediaQuery.of(context).size.shortestSide;
        if (shortestSide < 600) {
          return mobileLayout;
        }
        if (constraints.maxWidth < 1100) {
          return tabletLayout;
        } else {
          return desktopLayout;
        }
      },
    );
  }
}