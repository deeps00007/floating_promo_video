import 'package:flutter/material.dart';

import '../data/models.dart';
import '../theme.dart';

class CartPage extends StatelessWidget {
  final int cartCount;
  const CartPage({Key? key, required this.cartCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = kProducts.take(cartCount.clamp(0, kProducts.length)).toList();
    final total = items.fold<double>(0.0, (sum, p) => sum + p.price);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(floating: true, snap: true, title: Text('My Cart')),
        if (items.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text('Your cart is empty',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey)),
                  const SizedBox(height: 8),
                  const Text('Add items to get started',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          )
        else ...[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _CartItem(product: items[i]),
                childCount: items.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10)
                  ],
                ),
                child: Column(
                  children: [
                    _OrderRow(
                        label: 'Subtotal',
                        value: '\$${total.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    const _OrderRow(label: 'Shipping', value: 'FREE'),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    _OrderRow(
                        label: 'Total',
                        value: '\$${total.toStringAsFixed(2)}',
                        bold: true),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16)),
                        child: const Text('Proceed to Checkout',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _CartItem extends StatelessWidget {
  final Product product;
  const _CartItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                    width: 64, height: 64, color: Colors.grey.shade100);
              },
              errorBuilder: (_, __, ___) => Container(
                width: 64,
                height: 64,
                color: Colors.grey.shade100,
                child: const Icon(Icons.image_not_supported_outlined,
                    size: 24, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(product.category,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Text('\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 15, color: kPrimary)),
        ],
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const _OrderRow(
      {required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
                fontSize: bold ? 15 : 13,
                color: bold ? kSecondary : Colors.grey)),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: bold ? 16 : 13,
                color: bold ? kPrimary : kSecondary)),
      ],
    );
  }
}
