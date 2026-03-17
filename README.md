# floating_promo_video

A Flutter package that shows a **draggable floating promo video** (Reel/story style) over your UI.

It supports:
- Instagram media via a backend token endpoint
- Direct/fallback video URLs
- Expand/collapse on tap
- Mute/unmute and close controls
- Session-level close state

## Preview

![Preview 1](https://ik.imagekit.io/projectss/Screenshot_2026-03-17-13-23-56-30_e3be76f344a504139ded1167e197fd03.jpg.jpeg)

![Preview 2](https://ik.imagekit.io/projectss/Screenshot_2026-03-17-13-24-10-00_e3be76f344a504139ded1167e197fd03.jpg.jpeg)

## Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
	floating_promo_video: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Quick Start (Recommended)

Use `FloatingPromoVideoOverlay` to wrap your page content.

```dart
import 'package:flutter/material.dart';
import 'package:floating_promo_video/floating_promo_video.dart';

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

## Direct URLs Only (No backend)

If you don’t want Instagram token flow, use direct URLs:

```dart
FloatingPromoVideoOverlay.fromUrls(
	child: const YourScreen(),
	urls: const [
		'https://example.com/video1.mp4',
		'https://example.com/video2.mp4',
	],
)
```

## Alternative: Manual Placement

If you already have a custom `Stack`, you can place the widget manually:

```dart
Stack(
	children: [
		const YourContent(),
		FloatingPromotionVideo(
			tokenApiUrl: 'https://yourbackend.com/api/instagram-token',
			fallbackUrls: const ['https://example.com/promo.mp4'],
		),
	],
)
```

Or direct URLs:

```dart
FloatingPromotionVideo.fromUrls(
	urls: const ['https://example.com/promo.mp4'],
)
```

## Backend Response Contract

Your `tokenApiUrl` endpoint should return:

```json
{
	"status": true,
	"data": [
		{ "api_key": "YOUR_INSTAGRAM_ACCESS_TOKEN" }
	]
}
```

The package then requests:

`https://graph.instagram.com/me/media?fields=media_url,media_type&access_token=<token>&limit=5`

Only `VIDEO` media items are used.

## Public API

### `FloatingPromoVideoOverlay`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `child` | `Widget` | required | Your page/widget content |
| `tokenApiUrl` | `String` | required | Backend endpoint for Instagram token |
| `fallbackUrls` | `List<String>` | built-in 2 demo URLs | Used when backend/Instagram fails |
| `accentColor` | `Color` | `Color(0xFFF60000)` | Progress bar color |
| `initialLeft` | `double` | `16.0` | Initial left position |
| `initialBottom` | `double` | `16.0` | Initial bottom position |

Factory:
- `FloatingPromoVideoOverlay.fromUrls(...)` for URL-only mode.

### `FloatingPromotionVideo`

Same parameter set as above, but used for manual `Stack` placement.

Factory:
- `FloatingPromotionVideo.fromUrls(...)`

Static session flag:
- `FloatingPromotionVideo.isClosedForSession`
	- becomes `true` when user taps close
	- widget stays hidden for the current app session

## Behavior Notes

- Starts muted by default.
- Tap widget to expand/collapse.
- Drag to move; it snaps left/right after drag end.
- Close button hides it for this session.
- If `tokenApiUrl` is empty (`''`), the widget directly uses `fallbackUrls`.

## Best Practices

- **Recommended placement**: wrap only your **body content** with `FloatingPromoVideoOverlay`.
	- This avoids overlap with `bottomNavigationBar`.
- Provide at least one valid MP4 URL in `fallbackUrls`.
- Use CDN-hosted videos for better startup and buffering performance.

## Reset Session Close (Optional)

If you want to show the widget again in the same app session:

```dart
FloatingPromotionVideo.isClosedForSession = false;
```

## Troubleshooting

### Widget not visible
- Ensure at least one playable video URL is available.
- Verify backend response structure exactly matches the contract.
- Confirm network access to both backend and video URLs.

### Instagram videos not loading
- Access token might be expired/invalid.
- Endpoint may return non-video media; only `VIDEO` items are used.
- Backend may be returning `status: false` or empty `data`.

### Video overlaps bottom navigation
- Wrap only the screen body with `FloatingPromoVideoOverlay`, not the whole app shell.

## Exports

Main entrypoint:

```dart
import 'package:floating_promo_video/floating_promo_video.dart';
```

This exports:
- `FloatingPromotionVideo`
- `FloatingPromoVideoOverlay`
- plus supporting widgets used internally by the package

