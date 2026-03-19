<div align="center">
 
# floating_promo_video
 
[![License](https://img.shields.io/badge/license-MIT-orange?style=flat-square)](LICENSE)
[![Pub Version](https://img.shields.io/badge/pub-v0.0.1-blue?style=flat-square)](https://pub.dev/packages/floating_promo_video)
[![Flutter](https://img.shields.io/badge/built%20with-Flutter-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-lightgrey?style=flat-square)](https://flutter.dev)
 
**A draggable, floating promo/reel video widget for any Flutter screen.**
 
Fades in smoothly, expands to fullscreen on tap, supports Instagram Reels, and works with plain MP4 URLs — no backend required.
 
</div>
 
---
 
## Preview
 
<table style="border:none; text-align:center;">
  <tr>
    <td><b>The Inspiration (Zepto)</b></td>
    <td></td>
    <td colspan="2"><b>What you can build in minutes</b></td>
  </tr>
  <tr>
    <td valign="middle">
      <a href="https://ik.imagekit.io/projectss/Screenshot_2026-03-17-17-41-08-08_d13708f0377555913763db32da1326f2.jpg%20(1).jpeg?updatedAt=1773751312469">
        <img src="https://ik.imagekit.io/projectss/Screenshot_2026-03-17-17-41-08-08_d13708f0377555913763db32da1326f2.jpg%20(1).jpeg?updatedAt=1773751312469&tr=w-180" width="180" alt="Zepto Inspiration" />
      </a>
    </td>
    <td valign="middle" style="font-size:28px;">➡️</td>
    <td valign="middle">
      <a href="https://ik.imagekit.io/projectss/Screenshot_2026-03-17-13-23-56-30_e3be76f344a504139ded1167e197fd03.jpg.jpeg">
        <img src="https://ik.imagekit.io/projectss/Screenshot_2026-03-17-13-23-56-30_e3be76f344a504139ded1167e197fd03.jpg.jpeg?tr=w-180" width="180" alt="Preview 1" />
      </a>
    </td>
    <td valign="middle">
      <a href="https://ik.imagekit.io/projectss/Screenshot_2026-03-17-17-29-39-27_e3be76f344a504139ded1167e197fd03.jpg.jpeg">
        <img src="https://ik.imagekit.io/projectss/Screenshot_2026-03-17-17-29-39-27_e3be76f344a504139ded1167e197fd03.jpg.jpeg?tr=w-180" width="180" alt="Preview 2" />
      </a>
    </td>
  </tr>
</table>
 
*Click any image to open full size.*
 
---
 
## Why floating_promo_video?
 
| Feature | Zepto App | floating_promo_video |
|---|:---:|:---:|
| Floating video promo | ✅ | ✅ |
| Drag to reposition | ✅ | ✅ |
| Expand to fullscreen | ✅ | ✅ |
| Instagram Reels support | ❌ | ✅ |
| Plug & play for devs | ❌ | ✅ |
| Works without backend | ❌ | ✅ |
| Fully customizable | ❌ | ✅ |
 
What takes a full engineering effort in production apps can now be added in **minutes**.
 
---
 
## Use Cases
 
| App Type | Use Case |
|---|---|
| **E-commerce** | Show flash offers like Zepto |
| **EdTech** | Promote courses and new modules |
| **OTT Apps** | Highlight trending or new content |
| **SaaS** | Announce feature releases |
| **Consumer Apps** | Showcase new features in-app |
 
---
 
## Installation
 
Add to your `pubspec.yaml`:
 
```yaml
dependencies:
  floating_promo_video: ^0.0.1
```
 
Then run:
 
```bash
flutter pub get
```
 
```dart
import 'package:floating_promo_video/floating_promo_video.dart';
```
 
---
 
## Quick Start
 
Three integration paths — pick the one that fits your setup.
 
---
 
### Option 1 — Drop-in Scaffold *(Recommended)*
 
Replace your `Scaffold(...)` with `FloatingPromoVideoScaffold(...)`. Nothing else changes.
 
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
 
---
 
### Option 2 — Overlay on Page Body
 
Wrap only your page body with `FloatingPromoVideoOverlay`. This keeps the widget clear of the bottom navigation bar.
 
**With Instagram backend:**
 
```dart
Scaffold(
  body: FloatingPromoVideoOverlay(
    tokenApiUrl: 'https://yourbackend.com/api/instagram-token',
    fallbackUrls: const [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    ],
    child: const Center(child: Text('Your screen content')),
  ),
)
```
 
**URL-only mode (no backend needed):**
 
```dart
FloatingPromoVideoOverlay.fromUrls(
  urls: const [
    'https://example.com/video1.mp4',
    'https://example.com/video2.mp4',
  ],
  child: const YourScreen(),
)
```
 
---
 
### Option 3 — Manual Stack Placement
 
Full layout control — place the widget yourself inside a `Stack`.
 
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
 
---
 
## Instagram Integration
 
To play your own Reels, the package fetches videos from the Instagram Graph API using a token served from your own backend. The token never lives inside the app — your backend hands it over only when asked.
 
### What your backend must return
 
```json
{
  "status": true,
  "data": [
    { "api_key": "YOUR_LONG_LIVED_INSTAGRAM_ACCESS_TOKEN" }
  ]
}
```
 
### Example PHP endpoint (`instaapi.php`)
 
```php
<?php
header('Content-Type: application/json');
 
$instagram_token = "IGAAWp7Lk... (your valid long-lived token)";
 
echo json_encode([
    "status" => true,
    "data" => [["api_key" => $instagram_token]]
]);
?>
```
 
### How the package uses your token
 
Once retrieved, the package automatically calls:
 
```
https://graph.instagram.com/me/media?fields=media_url,media_type&access_token=<TOKEN>&limit=5
```
 
It filters for `VIDEO` media and plays them in the floating widget automatically.
 
> **Tip:** Set `tokenApiUrl` to `''` to skip the backend entirely and use `fallbackUrls` directly.
 
---
 
## API Reference
 
### FloatingPromoVideoScaffold / FloatingPromoVideoOverlay
 
| Parameter | Type | Default | Description |
|---|---|---|---|
| `child` | `Widget` | required | Content shown behind the floating video |
| `tokenApiUrl` | `String` | required | Backend endpoint returning the Instagram token |
| `fallbackUrls` | `List<String>` | built-in demo URLs | Used when backend or Instagram is unavailable |
| `accentColor` | `Color` | `Color(0xFFF60000)` | Story progress bar color |
| `initialLeft` | `double` | `16.0` | Starting distance from the left edge |
| `initialBottom` | `double` | `16.0` | Starting distance from the bottom edge |
 
Both support a `.fromUrls(...)` factory constructor for URL-only mode.
 
---
 
### FloatingPromotionVideo
 
Same parameters as above. Designed for manual `Stack` placement.
 
**Session state:**
 
```dart
// True once the user closes the widget for this session
FloatingPromotionVideo.isClosedForSession;
 
// Reset to show the widget again
FloatingPromotionVideo.isClosedForSession = false;
```
 
---
 
## Widget Behavior
 
| Interaction | Result |
|---|---|
| Page loads | Fades and scales in after a 3-second delay |
| Tap widget | Expands to full-screen player |
| Close full-screen | Returns to the last dragged position |
| Drag widget | Freely repositionable; snaps to nearest edge on release |
| Tap mute/unmute | Toggles audio (starts muted by default) |
| Tap close button | Outro animation plays; widget hidden for the session |
 
---
 
## Best Practices
 
- Wrap only the **page body** with `FloatingPromoVideoOverlay`, not the full app shell — prevents overlap with `bottomNavigationBar`
- Always provide at least **one valid fallback MP4 URL**
- Use **CDN-hosted videos** for faster startup and smoother playback
- Use **long-lived Instagram tokens** from the Facebook Developer Portal to avoid frequent expiry
 
---
 
## Troubleshooting
 
**Widget not visible**
- Ensure at least one URL in `fallbackUrls` is a publicly accessible MP4
- Verify your backend returns exactly the JSON format shown above
- Check device network access to both the backend and video URLs
 
**Instagram videos not loading**
- Access token may be expired — regenerate from the Facebook Developer Portal
- Your account may have no `VIDEO` media (photo-only accounts return nothing playable)
- Confirm backend returns `"status": true` with a non-empty `"data"` array
 
**Widget overlaps bottom navigation bar**
- Use `FloatingPromoVideoScaffold` (Option 1), or wrap only the `body` — not the entire `Scaffold`
 
---
 
<div align="center">
 
Built with ♥ for Flutter developers
 
</div>