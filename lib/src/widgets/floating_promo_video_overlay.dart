import 'package:flutter/material.dart';

import 'floating_promo_video.dart';

/// The easiest way to add a floating promo video to any screen.
///
/// Wraps [child] in a [Stack] and places [FloatingPromotionVideo] on top
/// automatically — no manual Stack or Positioned needed.
class FloatingPromoVideoOverlay extends StatelessWidget {
  final Widget child;
  final String tokenApiUrl;
  final List<String> fallbackUrls;
  final Color accentColor;
  final double initialLeft;
  final double initialBottom;

  const FloatingPromoVideoOverlay({
    Key? key,
    required this.child,
    required this.tokenApiUrl,
    this.fallbackUrls = const [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ],
    this.accentColor = const Color(0xFFF60000),
    this.initialLeft = 16.0,
    this.initialBottom = 16.0,
  }) : super(key: key);

  /// Creates an overlay that plays [urls] directly — no backend needed.
  factory FloatingPromoVideoOverlay.fromUrls({
    Key? key,
    required Widget child,
    required List<String> urls,
    Color accentColor = const Color(0xFFF60000),
    double initialLeft = 16.0,
    double initialBottom = 16.0,
  }) {
    return FloatingPromoVideoOverlay(
      key: key,
      child: child,
      tokenApiUrl: '',
      fallbackUrls: urls,
      accentColor: accentColor,
      initialLeft: initialLeft,
      initialBottom: initialBottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        FloatingPromotionVideo(
          tokenApiUrl: tokenApiUrl,
          fallbackUrls: fallbackUrls,
          accentColor: accentColor,
          initialLeft: initialLeft,
          initialBottom: initialBottom,
        ),
      ],
    );
  }
}
