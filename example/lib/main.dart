// ╔══════════════════════════════════════════════════════════╗
// ║          📦 floating_promo_video — PACKAGE IMPORT         ║
// ╚══════════════════════════════════════════════════════════╝
import 'package:floating_promo_video/floating_promo_video.dart';

import 'package:flutter/material.dart';

// import 'data/models.dart';
import 'screens/cart_page.dart';
import 'screens/category_page.dart';
import 'screens/profile_page.dart';
import 'screens/store_page.dart';
import 'theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopNow',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeScreen(),
    );
  }
}

// â”€â”€ Root Shell â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _cartCount = 0;

  void _addToCart() => setState(() => _cartCount++);

  @override
  Widget build(BuildContext context) {
    final pages = [
      StorePage(onAddToCart: _addToCart),
      const CategoryPage(),
      CartPage(cartCount: _cartCount),
      const ProfilePage(),
    ];

    return FloatingPromoVideoScaffold(
      tokenApiUrl: 'https://example.com/instagramTokenApi',
      fallbackUrls: const [
        'flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ],
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('$_cartCount'),
              isLabelVisible: _cartCount > 0,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            selectedIcon: Badge(
              label: Text('$_cartCount'),
              isLabelVisible: _cartCount > 0,
              child: const Icon(Icons.shopping_bag),
            ),
            label: 'Cart',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
