# floating_promo_video

A Flutter widget package to show a draggable, floating promo/reel video over any screen.

## Why use it?

- Plug-and-play overlay (`FloatingPromoVideoOverlay`) for fast integration
- Supports Instagram media via your backend token endpoint
- Works without backend using direct MP4 URLs
- Tap to expand/collapse, drag to reposition, mute/unmute, close for session

## Preview

![Preview 1](https://ik.imagekit.io/projectss/Screenshot_2026-03-17-13-23-56-30_e3be76f344a504139ded1167e197fd03.jpg.jpeg)

![Preview 2](https://ik.imagekit.io/projectss/Screenshot_2026-03-17-13-24-10-00_e3be76f344a504139ded1167e197fd03.jpg.jpeg)

## Installation

```yaml
dependencies:
  floating_promo_video: ^0.0.1
```

```bash
flutter pub get
```

## Quick start (recommended)

Wrap your page body with `FloatingPromoVideoOverlay`:

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

## URL-only mode (no backend)

```dart
FloatingPromoVideoOverlay.fromUrls(
  child: const YourScreen(),
  urls: const [
    'https://example.com/video1.mp4',
    'https://example.com/video2.mp4',
  ],
)
```

## Manual mode (custom Stack)

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

Direct URL factory:

```dart
FloatingPromotionVideo.fromUrls(
  urls: const ['https://example.com/promo.mp4'],
)
```

## Backend response format

Your `tokenApiUrl` should return:

```json
{
  "status": true,
  "data": [
    { "api_key": "YOUR_INSTAGRAM_ACCESS_TOKEN" }
  ]
}
```

The package fetches media from:

`https://graph.instagram.com/me/media?fields=media_url,media_type&access_token=<token>&limit=5`

Only `VIDEO` media entries are used.

## API reference

### FloatingPromoVideoOverlay

| Parameter | Type | Default | Description |
|---|---|---|---|
| `child` | `Widget` | required | Content shown behind floating video |
| `tokenApiUrl` | `String` | required | Backend endpoint that returns Instagram token |
| `fallbackUrls` | `List<String>` | built-in demo URLs | Used when backend/Instagram is unavailable |
| `accentColor` | `Color` | `Color(0xFFF60000)` | Story progress bar color |
| `initialLeft` | `double` | `16.0` | Initial distance from left edge |
| `initialBottom` | `double` | `16.0` | Initial distance from bottom edge |

Factory constructor:
- `FloatingPromoVideoOverlay.fromUrls(...)`

### FloatingPromotionVideo

Same parameters as overlay version, for manual placement in your own `Stack`.

Factory constructor:
- `FloatingPromotionVideo.fromUrls(...)`

Static session state:
- `FloatingPromotionVideo.isClosedForSession`
  - Becomes `true` when user closes the widget
  - Keeps widget hidden for the current app session

## Behavior

- Starts muted by default
- Tap to expand/collapse
- Drag to reposition (snaps to left/right edge on drag end)
- Close button hides widget for session
- Empty `tokenApiUrl` (`''`) skips backend and uses `fallbackUrls` directly

## Best practices

- Wrap only **page body content** with `FloatingPromoVideoOverlay`
  - This avoids overlap with `bottomNavigationBar`
- Provide at least one valid MP4 URL in `fallbackUrls`
- Prefer CDN-hosted video URLs for faster startup and smoother playback

## Reset session close state

```dart
FloatingPromotionVideo.isClosedForSession = false;
```

## Troubleshooting

### Widget not visible
- Ensure at least one URL is playable
- Verify backend response format exactly matches contract
- Check network access to backend and video URLs

### Instagram media not loading
- Access token may be expired/invalid
- Endpoint may return media types other than `VIDEO`
- Backend may return `status: false` or empty `data`

### Overlapping bottom navigation
- Wrap only the screen body with `FloatingPromoVideoOverlay`, not the full app shell

## Import

```dart
import 'package:floating_promo_video/floating_promo_video.dart';
```

