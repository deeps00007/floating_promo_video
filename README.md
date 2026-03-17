# floating_promo_video

A draggable floating promo/reel video widget for Flutter apps.

## Preview

![Preview 1](https://ik.imagekit.io/projectss/Screenshot_2026-03-17-13-23-56-30_e3be76f344a504139ded1167e197fd03.jpg.jpeg)

![Preview 2](https://ik.imagekit.io/projectss/Screenshot_2026-03-17-13-24-10-00_e3be76f344a504139ded1167e197fd03.jpg.jpeg)

## Features

- Floating draggable video card
- Expand/collapse behavior
- Mute/unmute controls
- Session-based close behavior
- Use Instagram token API or direct video URLs

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
	floating_promo_video: ^0.0.1
```

## Quick Start

```dart
import 'package:floating_promo_video/floating_promo_video.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
	const DemoPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: FloatingPromoVideoOverlay(
				tokenApiUrl: 'https://yourbackend.com/api/instagram-token',
				fallbackUrls: const [
					'https://ik.imagekit.io/projectss/new-launch.mp4',
				],
				child: const Center(child: Text('Your screen content')),
			),
		);
	}
}
```

## Direct URLs (No backend)

```dart
FloatingPromoVideoOverlay.fromUrls(
	child: YourScreen(),
	urls: const [
		'https://example.com/video1.mp4',
		'https://example.com/video2.mp4',
	],
)
```

## Notes

- Set `tokenApiUrl: ''` to skip Instagram fetch and use `fallbackUrls` directly.
- Place the overlay on your `body` content (recommended), not around whole app shell.

