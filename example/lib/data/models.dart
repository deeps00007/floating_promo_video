import 'package:flutter/material.dart';

// ── Product ───────────────────────────────────────────────────────────────────

class Product {
  final String name;
  final String category;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviews;
  final String imageUrl;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });

  int get discountPercent =>
      (((originalPrice - price) / originalPrice) * 100).round();
}

const kProducts = [
  Product(
    name: 'Wireless Earbuds Pro',
    category: 'Electronics',
    price: 49.99,
    originalPrice: 79.99,
    rating: 4.8,
    reviews: 1240,
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=400&fit=crop',
  ),
  Product(
    name: 'Running Sneakers X',
    category: 'Fashion',
    price: 89.99,
    originalPrice: 129.99,
    rating: 4.6,
    reviews: 832,
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=400&fit=crop',
  ),
  Product(
    name: 'Smart Watch Series 5',
    category: 'Electronics',
    price: 199.99,
    originalPrice: 299.99,
    rating: 4.9,
    reviews: 2103,
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=400&fit=crop',
  ),
  Product(
    name: 'Leather Handbag',
    category: 'Fashion',
    price: 69.99,
    originalPrice: 99.99,
    rating: 4.5,
    reviews: 561,
    imageUrl:
        'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400&h=400&fit=crop',
  ),
  Product(
    name: 'Coffee Maker Deluxe',
    category: 'Home',
    price: 59.99,
    originalPrice: 89.99,
    rating: 4.7,
    reviews: 428,
    imageUrl:
        'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=400&fit=crop',
  ),
  Product(
    name: 'Yoga Mat Premium',
    category: 'Sports',
    price: 34.99,
    originalPrice: 49.99,
    rating: 4.4,
    reviews: 317,
    imageUrl:
        'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400&h=400&fit=crop',
  ),
  Product(
    name: 'Face Serum Gold',
    category: 'Beauty',
    price: 44.99,
    originalPrice: 64.99,
    rating: 4.8,
    reviews: 920,
    imageUrl:
        'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=400&h=400&fit=crop',
  ),
  Product(
    name: 'Bluetooth Speaker',
    category: 'Electronics',
    price: 79.99,
    originalPrice: 119.99,
    rating: 4.6,
    reviews: 754,
    imageUrl:
        'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=400&h=400&fit=crop',
  ),
];

// ── Category ──────────────────────────────────────────────────────────────────

class AppCategory {
  final String name;
  final IconData icon;
  final Color color;
  const AppCategory(this.name, this.icon, this.color);
}

const kCategories = [
  AppCategory('All', Icons.apps, Color(0xFF4F46E5)),
  AppCategory('Electronics', Icons.devices, Color(0xFF6C63FF)),
  AppCategory('Fashion', Icons.checkroom, Color(0xFFE91E63)),
  AppCategory('Home', Icons.chair, Color(0xFF795548)),
  AppCategory('Beauty', Icons.face_retouching_natural, Color(0xFFFFC107)),
  AppCategory('Sports', Icons.sports_soccer, Color(0xFF4CAF50)),
];
