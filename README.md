<div align="center">

<img src="https://raw.githubusercontent.com/gvenusleo/MeRead/master/assets/icon/icon.png" width="100" alt="MeRead Logo" />

# MeRead

### *Project Refactoring*

**A concise and easy-to-use RSS reader built with [Flutter](https://flutter.dev) and designed with [Material You](https://m3.material.io)**

[![License](https://img.shields.io/badge/license-GPL--3.0-orange?style=flat-square)](LICENSE)
[![Release](https://img.shields.io/badge/release-v0.6.1-blue?style=flat-square)](https://github.com/gvenusleo/MeRead/releases)
[![Downloads](https://img.shields.io/badge/downloads-7.3k-brightgreen?style=flat-square)](https://github.com/gvenusleo/MeRead/releases)
[![Flutter](https://img.shields.io/badge/built%20with-Flutter-02569B?style=flat-square&logo=flutter)](https://flutter.dev)

English | [简体中文](README_ZH.md)

</div>

---

## Screenshots

<div align="center">
<table>
  <tr>
    <td align="center"><img src="https://raw.githubusercontent.com/gvenusleo/MeRead/master/assets/screenshots/1.png" width="180" alt="Feed List" /><br/><sub>Feed List</sub></td>
    <td align="center"><img src="https://raw.githubusercontent.com/gvenusleo/MeRead/master/assets/screenshots/2.png" width="180" alt="Article View" /><br/><sub>Article View</sub></td>
    <td align="center"><img src="https://raw.githubusercontent.com/gvenusleo/MeRead/master/assets/screenshots/3.png" width="180" alt="Edit Feed" /><br/><sub>Edit Feed</sub></td>
    <td align="center"><img src="https://raw.githubusercontent.com/gvenusleo/MeRead/master/assets/screenshots/4.png" width="180" alt="Settings" /><br/><sub>Settings</sub></td>
  </tr>
</table>
</div>

---

## Overview

MeRead is a clean, minimal RSS reader for Android, built with Flutter and following Material You design guidelines. It adapts to your device's dynamic color theme, making it feel right at home on any Android 12+ device.

The project is currently undergoing a **major refactoring** to improve performance, architecture, and feature coverage. Contributions and feedback are welcome.

---

## Features

- **RSS / Atom feed support** — subscribe to any standard RSS or Atom feed
- **Material You design** — dynamic color theming that adapts to your wallpaper on Android 12+
- **Clean reading experience** — distraction-free article view
- **Feed management** — add, edit, and organize your subscriptions easily
- **Multilingual support** — available in English and Simplified Chinese
- **Lightweight** — built with Flutter for smooth, native-like performance
- **Offline-friendly** — read cached articles without an active connection

---

## Installation

### Download APK

Download the latest release from the [Releases page](https://github.com/gvenusleo/MeRead/releases).

### Build from Source

**Prerequisites:**
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio or VS Code with Flutter plugin

**Steps:**

```bash
# Clone the repository
git clone https://github.com/gvenusleo/MeRead.git
cd MeRead

# Install dependencies
flutter pub get

# Run on a connected device or emulator
flutter run

# Build a release APK
flutter build apk --release
```

---

## Project Structure

```
MeRead/
├── lib/
│   ├── main.dart              # App entry point
│   ├── models/                # Data models (Feed, Article)
│   ├── pages/                 # Screens (Home, Reader, Settings)
│   ├── services/              # RSS parsing, HTTP, storage
│   ├── widgets/               # Reusable UI components
│   └── utils/                 # Helpers and constants
├── assets/
│   └── icon/                  # App icons
├── android/                   # Android-specific config
└── pubspec.yaml               # Dependencies
```

---

## Dependencies

| Package | Purpose |
|---|---|
| `flutter` | UI framework |
| `http` | Network requests for fetching feeds |
| `webfeed` | RSS / Atom feed parsing |
| `sqflite` | Local database for storing feeds and articles |
| `shared_preferences` | Persisting user settings |
| `dynamic_color` | Material You dynamic theming |
| `flutter_html` | Rendering article HTML content |

> See [`pubspec.yaml`](pubspec.yaml) for the full and up-to-date list.

---

## Contributing

Contributions are welcome! Here's how to get started:

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/your-feature-name`
3. **Commit** your changes: `git commit -m 'Add: your feature description'`
4. **Push** to your branch: `git push origin feature/your-feature-name`
5. **Open** a Pull Request

Please open an issue first for major changes to discuss what you'd like to change.

---

## Roadmap

- [ ] OPML import / export
- [ ] Feed categories and grouping
- [ ] Article search
- [ ] Sync with external RSS services (Fever, Miniflux)
- [ ] Widget support for home screen
- [ ] iOS support

---

## License

This project is licensed under the **GNU General Public License v3.0**.
See the [LICENSE](LICENSE) file for full details.

---

<div align="center">

Made with ♥ using Flutter

</div>