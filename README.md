# floating_promo_video

A Flutter widget package to show a draggable, floating promo/reel video over any screen.

## Why use it?

- Plug-and-play overlay (`FloatingPromoVideoOverlay`) for fast integration
- Smoothly fades and scales in 3 seconds after page load
- Expands into an immersive full-screen video player on tap
- Supports Instagram media via your backend token endpoint
- Works without backend using direct MP4 URLs
- Drag to reposition, mute/unmute, and dismiss for the session 

## Preview

[<img src="https://ik.imagekit.io/projectss/Screenshot_2026-03-17-13-23-56-30_e3be76f344a504139ded1167e197fd03.jpg.jpeg?tr=w-260" alt="Preview 1" width="260" />](https://ik.imagekit.io/projectss/Screenshot_2026-03-17-13-23-56-30_e3be76f344a504139ded1167e197fd03.jpg.jpeg)
[<img src="https://ik.imagekit.io/projectss/Screenshot_2026-03-17-17-29-39-27_e3be76f344a504139ded1167e197fd03.jpg.jpeg?tr=w-260" alt="Preview 2" width="260" />](https://ik.imagekit.io/projectss/Screenshot_2026-03-17-17-29-39-27_e3be76f344a504139ded1167e197fd03.jpg.jpeg)

Click either image to open full size.

## Installation

```yaml
dependencies:
  floating_promo_video: ^0.0.1
```

```bash
flutter pub get
```

## Quick start (recommended)

### Simplest (drop-in Scaffold)

Replace your `Scaffold(...)` with `FloatingPromoVideoScaffold(...)`:

```dart
import 'package:flutter/material.dart';
import 'package:floating_promo_video/floating_promo_video.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingPromoVideoScaffold.fromUrls(
      urls: const ['https://example.com/promo.mp4'],
      body: const Center(child: Text('Your screen content')),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (_) {},
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

### Overlay (wrap body)

Wrap your page body with `FloatingPromoVideoOverlay`:

```dart
import 'package:flutter/material.dart';
import 'package:floating_promo_video/floating_promo_video.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingPromoVideoOverlay(
        tokenApiUrl: 'https://yourbackend.com/api/instagram-token',
        fallbackUrls: const [
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
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

## 🛠 How the Instagram API Integration Works (Backend)

To play your own Instagram reels, the package needs to hit the official Instagram Graph API. However, for security, you should never hardcode your Instagram Access Token inside the app.

Instead, you provide a `tokenApiUrl` (e.g., `https://yourdomain.com/instaapi.php`). The app will call this URL to securely fetch your token, and then use that token to fetch your latest 5 Reels.

### 1. What your Backend must return

Your API endpoint (e.g. `instaapi.php`) MUST return JSON in this exact structure:

```json
{
  "status": true,
  "data": [
    { "api_key": "YOUR_LONG_LIVED_INSTAGRAM_ACCESS_TOKEN" }
  ]
}
```

### 2. Example PHP Implementation (`instaapi.php`)

Here is a simple example of how your PHP script should look:

```php
<?php
header('Content-Type: application/json');

// Get this token from your Facebook/Instagram Developer Portal
// Make sure it is a Long-Lived User Access Token
$instagram_token = "IGAAWp7Lk... (your valid token here)";

$response = [
    "status" => true,
    "data" => [
        [
            "api_key" => $instagram_token
        ]
    ]
];

echo json_encode($response);
?>
```

### 3. How the package uses it

Once the package securely receives your token from your backend, it automatically calls the Instagram Graph API behind the scenes:
`https://graph.instagram.com/me/media?fields=media_url,media_type&access_token=<YOUR_TOKEN>&limit=5`

It extracts all `VIDEO` media files and plays them smoothly in the floating widget!

## API reference

### FloatingPromoVideoScaffold

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

- Smoothly appears after a 3-second delay with fade & scale animations
- Starts muted by default
- Tap to expand into a full-screen view (saves original dragged position)
- Drag to reposition (snaps to left/right edge on drag end)
- Close button triggers an outro animation and hides widget for the session
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

