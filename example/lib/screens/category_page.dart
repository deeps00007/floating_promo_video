import 'package:flutter/material.dart';

import '../theme.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  static const List<Map<String, dynamic>> _cats = [
    {
      'label': 'Electronics',
      'icon': Icons.devices,
      'color': Color(0xFF6C63FF),
      'items': '1,240 items'
    },
    {
      'label': 'Fashion',
      'icon': Icons.checkroom,
      'color': Color(0xFFE91E63),
      'items': '3,850 items'
    },
    {
      'label': 'Home & Living',
      'icon': Icons.chair,
      'color': Color(0xFF795548),
      'items': '920 items'
    },
    {
      'label': 'Beauty',
      'icon': Icons.face_retouching_natural,
      'color': Color(0xFFFFC107),
      'items': '1,580 items'
    },
    {
      'label': 'Sports',
      'icon': Icons.sports_soccer,
      'color': Color(0xFF4CAF50),
      'items': '730 items'
    },
    {
      'label': 'Toys & Kids',
      'icon': Icons.toys,
      'color': Color(0xFF00BCD4),
      'items': '610 items'
    },
    {
      'label': 'Groceries',
      'icon': Icons.shopping_basket,
      'color': Color(0xFF8BC34A),
      'items': '2,100 items'
    },
    {
      'label': 'Books',
      'icon': Icons.menu_book,
      'color': Color(0xFF8B5CF6),
      'items': '4,400 items'
    },
    {
      'label': 'Automotive',
      'icon': Icons.directions_car,
      'color': Color(0xFF607D8B),
      'items': '870 items'
    },
    {
      'label': 'Health',
      'icon': Icons.health_and_safety,
      'color': Color(0xFFF44336),
      'items': '1,300 items'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          snap: true,
          title: Text('Categories'),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final c = _cats[i];
                final color = c['color'] as Color;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -16,
                        bottom: -16,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color.withValues(alpha: 0.08),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(c['icon'] as IconData,
                                  color: color, size: 26),
                            ),
                            const SizedBox(height: 10),
                            Text(c['label'] as String,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: kSecondary)),
                            Text(c['items'] as String,
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: _cats.length,
            ),
          ),
        ),
      ],
    );
  }
}
