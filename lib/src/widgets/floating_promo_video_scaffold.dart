import 'package:flutter/material.dart';

import 'floating_promo_video_overlay.dart';

/// A convenience wrapper that makes integration as simple as replacing
/// `Scaffold(...)` with `FloatingPromoVideoScaffold(...)`.
///
/// This ensures the promo video is constrained to the Scaffold body area,
/// so it won't conflict with a `bottomNavigationBar`.
class FloatingPromoVideoScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;

  final String tokenApiUrl;
  final List<String> fallbackUrls;
  final Color accentColor;
  final double initialLeft;
  final double initialBottom;

  const FloatingPromoVideoScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    required this.tokenApiUrl,
    this.fallbackUrls = const [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ],
    this.accentColor = const Color(0xFFF60000),
    this.initialLeft = 16.0,
    this.initialBottom = 16.0,
  }) : super(key: key);

  /// Creates a scaffold that plays [urls] directly — no backend needed.
  factory FloatingPromoVideoScaffold.fromUrls({
    Key? key,
    PreferredSizeWidget? appBar,
    required Widget body,
    Widget? bottomNavigationBar,
    FloatingActionButton? floatingActionButton,
    required List<String> urls,
    Color accentColor = const Color(0xFFF60000),
    double initialLeft = 16.0,
    double initialBottom = 16.0,
  }) {
    return FloatingPromoVideoScaffold(
      key: key,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      tokenApiUrl: '',
      fallbackUrls: urls,
      accentColor: accentColor,
      initialLeft: initialLeft,
      initialBottom: initialBottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: FloatingPromoVideoOverlay(
        tokenApiUrl: tokenApiUrl,
        fallbackUrls: fallbackUrls,
        accentColor: accentColor,
        initialLeft: initialLeft,
        initialBottom: initialBottom,
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
