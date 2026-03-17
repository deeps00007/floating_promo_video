import 'dart:async';

import 'package:flutter/material.dart';

import '../data/models.dart';
import '../theme.dart';

// ── Store Page ────────────────────────────────────────────────────────────────

class StorePage extends StatefulWidget {
  final VoidCallback onAddToCart;
  const StorePage({Key? key, required this.onAddToCart}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int _selectedCategory = 0;

  List<Product> get _filtered {
    if (_selectedCategory == 0) return kProducts;
    final cat = kCategories[_selectedCategory].name;
    return kProducts.where((p) => p.category == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App bar
        SliverAppBar(
          pinned: true,
          expandedHeight: 140,
          toolbarHeight: 64,
          backgroundColor: kPrimary,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4338CA), Color(0xFF7C3AED)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -30,
                    right: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 60,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 6, 12, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Brand pill
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.white30, width: 1),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.storefront,
                                        color: Colors.white, size: 13),
                                    SizedBox(width: 4),
                                    Text('ShopNow',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.5)),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              // Notification
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                          Icons.notifications_outlined,
                                          color: Colors.white,
                                          size: 19),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Container(
                                      width: 9,
                                      height: 9,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF3B30),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: const Color(0xFF4338CA),
                                            width: 1.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              // Cart
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                          Icons.shopping_bag_outlined,
                                          color: Colors.white,
                                          size: 19),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Positioned(
                                    top: -2,
                                    right: -2,
                                    child: Container(
                                      width: 17,
                                      height: 17,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: const Center(
                                        child: Text('3',
                                            style: TextStyle(
                                                color: kPrimary,
                                                fontSize: 9,
                                                fontWeight: FontWeight.w800)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              // Avatar
                              CircleAvatar(
                                radius: 19,
                                backgroundColor:
                                    Colors.white.withValues(alpha: 0.25),
                                child: const Text('A',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text('Good morning, Alex 👋',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          const Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  color: Colors.white70, size: 13),
                              SizedBox(width: 3),
                              Text('New York, USA',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              SizedBox(width: 2),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.white54, size: 16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Curved arch
                  Positioned(
                    bottom: -1,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 22,
                      decoration: const BoxDecoration(
                        color: kBg,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.07),
                          blurRadius: 10,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products, brands...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: Icon(Icons.search, color: kPrimary),
                      suffixIcon: Icon(Icons.tune, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const OfferCarousel(),
              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SectionHeader(
                    title: '⚡ Flash Sale', subtitle: 'Ends in 02:45:30'),
              ),
              const SizedBox(height: 12),

              // Category chips
              SizedBox(
                height: 40,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: kCategories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final selected = _selectedCategory == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: selected ? kPrimary : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 6)
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(kCategories[i].icon,
                                size: 16,
                                color: selected
                                    ? Colors.white
                                    : kCategories[i].color),
                            const SizedBox(width: 6),
                            Text(kCategories[i].name,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        selected ? Colors.white : kSecondary)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),

        // Products grid
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) => ProductCard(
                  product: _filtered[i], onAddToCart: widget.onAddToCart),
              childCount: _filtered.length,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Offer Carousel ────────────────────────────────────────────────────────────

class _OfferSlide {
  final List<Color> gradient;
  final String badge;
  final String headline;
  final String sub;
  final String cta;
  final String imageUrl;
  const _OfferSlide({
    required this.gradient,
    required this.badge,
    required this.headline,
    required this.sub,
    required this.cta,
    required this.imageUrl,
  });
}

const _kOffers = [
  _OfferSlide(
    gradient: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
    badge: 'LIMITED OFFER',
    headline: 'Up to 50% OFF',
    sub: 'on Top Brands',
    cta: 'Shop Now →',
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=220&h=220&fit=crop',
  ),
  _OfferSlide(
    gradient: [Color(0xFF6C63FF), Color(0xFF9B8FFF)],
    badge: 'NEW ARRIVALS',
    headline: 'Spring Collection',
    sub: 'Fresh styles just dropped',
    cta: 'Explore →',
    imageUrl:
        'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=220&h=220&fit=crop',
  ),
  _OfferSlide(
    gradient: [Color(0xFF11998E), Color(0xFF38EF7D)],
    badge: 'FLASH SALE',
    headline: 'Buy 2 Get 1 FREE',
    sub: 'On selected electronics',
    cta: 'Grab Deal →',
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=220&h=220&fit=crop',
  ),
  _OfferSlide(
    gradient: [Color(0xFF0EA5E9), Color(0xFF6366F1)],
    badge: 'WEEKEND ONLY',
    headline: 'Free Shipping',
    sub: 'On all orders above \$29',
    cta: 'Order Now →',
    imageUrl:
        'https://images.unsplash.com/photo-1553532434-5ab5b6b84993?w=220&h=220&fit=crop',
  ),
];

class OfferCarousel extends StatefulWidget {
  const OfferCarousel({Key? key}) : super(key: key);

  @override
  State<OfferCarousel> createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<OfferCarousel> {
  final PageController _ctrl = PageController();
  int _current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_current + 1) % _kOffers.length;
      _ctrl.animateToPage(next,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _ctrl,
            onPageChanged: (i) => setState(() => _current = i),
            itemCount: _kOffers.length,
            itemBuilder: (_, i) => _buildSlide(_kOffers[i]),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _kOffers.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _current == i ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _current == i ? kPrimary : Colors.grey,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlide(_OfferSlide s) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
            colors: s.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 8, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(s.badge,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1)),
                    ),
                    const SizedBox(height: 6),
                    Text(s.headline,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            height: 1.1)),
                    Text(s.sub,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(s.cta,
                          style: TextStyle(
                              color: s.gradient.first,
                              fontWeight: FontWeight.w700,
                              fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15)),
                ),
                Container(
                  width: 110,
                  height: 110,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 6))
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      s.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.white.withValues(alpha: 0.2),
                        child: const Icon(Icons.image_outlined,
                            color: Colors.white54, size: 40),
                      ),
                    ),
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

// ── Section Header ────────────────────────────────────────────────────────────

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  const SectionHeader({Key? key, required this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w800, color: kSecondary)),
        if (subtitle != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: kPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(subtitle!,
                style: const TextStyle(
                    fontSize: 12,
                    color: kPrimary,
                    fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }
}

// ── Product Card ──────────────────────────────────────────────────────────────

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onAddToCart;
  const ProductCard(
      {Key? key, required this.product, required this.onAddToCart})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _wishlisted = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.network(
                  p.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      height: 120,
                      color: Colors.grey.shade100,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!
                              : null,
                          color: kPrimary,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    height: 120,
                    color: Colors.grey.shade100,
                    child: const Icon(Icons.image_not_supported_outlined,
                        size: 40, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                      color: kPrimary, borderRadius: BorderRadius.circular(6)),
                  child: Text('-${p.discountPercent}%',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () => setState(() => _wishlisted = !_wishlisted),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                        _wishlisted ? Icons.favorite : Icons.favorite_border,
                        size: 16,
                        color: _wishlisted ? Colors.red : Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: kSecondary,
                          height: 1.3)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 13, color: Color(0xFFFFC107)),
                      const SizedBox(width: 2),
                      Text('${p.rating}',
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: kSecondary)),
                      Text(' (${p.reviews})',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\$${p.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: kPrimary)),
                          Text('\$${p.originalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough)),
                        ],
                      ),
                      GestureDetector(
                        onTap: widget.onAddToCart,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                              color: kPrimary, shape: BoxShape.circle),
                          child: const Icon(Icons.add,
                              size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
