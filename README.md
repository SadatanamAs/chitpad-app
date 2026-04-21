# ChitPad

**ChitPad — your thoughts, beautifully kept.**

A rich note-taking Flutter app with an interactive fox mascot, built with GetX for state management and navigation.

## Features

- **Rich Text Editor** — Powered by flutter_quill with formatting support
- **Fox Mascot** — Interactive companion throughout the app
- **Secure Storage** — Token and sensitive data stored via flutter_secure_storage
- **Auth Flow** — Login, register, and password recovery
- **Note Management** — Create, archive, and organize notes
- **Profile & Settings** — Appearance, notifications, and privacy controls
- **Google Fonts** — Beautiful typography with Nunito and DM Mono

## Tech Stack

- **Flutter** with Dart
- **GetX** — State management, routing, and dependency injection
- **flutter_quill** — Rich text editing
- **dio** — HTTP client for future API integration
- **flutter_secure_storage** — Encrypted local storage
- **flutter_svg** — SVG asset support
- **shimmer** — Loading effects
- **image_picker** — Profile photo selection

## Project Structure

```
lib/
├── main.dart
├── app_config.dart
├── app/
│   ├── providers/       # GetX controllers
│   ├── routes/          # App routing
│   ├── theme/           # Colors and theming
│   └── widgets/         # Shared widgets (FoxMascot, Logo, SplashScreen)
├── data/
│   ├── datasets/        # Static data
│   ├── models/          # Data models
│   ├── providers/       # API and mock data services
│   └── repositories/    # Auth and notes repositories
└── modules/
    ├── auth/            # Login, Register, Forgot Password
    ├── home/            # Home, Notes Tab, Archive Tab, Profile Tab
    ├── note_editor/     # Rich text note editor
    └── settings/        # Appearance, Notifications, Privacy, Edit Profile
```

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release
```

## Requirements

- Flutter SDK ^3.11.1
- Dart SDK ^3.11.1
- Android SDK (for Android builds)
- Xcode (for iOS/macOS builds)
