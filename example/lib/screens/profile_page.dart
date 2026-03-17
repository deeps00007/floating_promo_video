import 'package:flutter/material.dart';

import '../theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4338CA), Color(0xFF7C3AED)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 3)),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, size: 44, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Alex Johnson',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800)),
                  Text('alex@shopnow.com',
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(child: _StatCard(value: '12', label: 'Orders')),
                    SizedBox(width: 12),
                    Expanded(child: _StatCard(value: '5', label: 'Wishlist')),
                    SizedBox(width: 12),
                    Expanded(child: _StatCard(value: '3', label: 'Reviews')),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Account',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: kSecondary)),
                const SizedBox(height: 12),
                _MenuTile(
                    icon: Icons.shopping_bag_outlined,
                    label: 'My Orders',
                    color: kPrimary,
                    onTap: () {}),
                _MenuTile(
                    icon: Icons.location_on_outlined,
                    label: 'Delivery Address',
                    color: const Color(0xFF6C63FF),
                    onTap: () {}),
                _MenuTile(
                    icon: Icons.payment_outlined,
                    label: 'Payment Methods',
                    color: const Color(0xFF00BFA5),
                    onTap: () {}),
                _MenuTile(
                    icon: Icons.favorite_outline,
                    label: 'Wishlist',
                    color: const Color(0xFFE91E63),
                    onTap: () {}),
                const SizedBox(height: 20),
                const Text('Support',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: kSecondary)),
                const SizedBox(height: 12),
                _MenuTile(
                    icon: Icons.help_outline,
                    label: 'Help Centre',
                    color: const Color(0xFFFFC107),
                    onTap: () {}),
                _MenuTile(
                    icon: Icons.chat_bubble_outline,
                    label: 'Live Chat',
                    color: const Color(0xFF4CAF50),
                    onTap: () {}),
                _MenuTile(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    color: Colors.grey,
                    onTap: () {}),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8)
        ],
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w900, color: kPrimary)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _MenuTile(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ),
    );
  }
}
