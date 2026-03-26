# Praise the LORD Flutter - Build Guide

## Project Overview
This is a complete Flutter implementation of the "Praise the LORD" Bengali Christian Hymns app with 1,396 songs, Banglish search support, favorites management, and offline functionality.

## Project Structure

```
praise_the_lord_flutter/
├── lib/
│   ├── main.dart                 # App entry point and main navigation
│   ├── models/
│   │   └── song.dart             # Song data model
│   ├── providers/
│   │   └── songs_provider.dart   # State management using Provider
│   ├── screens/
│   │   ├── home_screen.dart      # Home screen with song list & search
│   │   ├── song_detail_screen.dart # Song detail view
│   │   ├── favorites_screen.dart # Favorites management
│   │   └── settings_screen.dart  # Settings & theme
│   └── utils/
│       └── banglish.dart         # Banglish transliteration utility
├── assets/
│   └── songs.json                # All 1,396 songs
├── pubspec.yaml                  # Dependencies and configuration
└── README.md                      # Project documentation
```

## Key Features

✅ **1,396 Bengali Hymns** - Complete song database
✅ **Dual Search** - Bengali and Banglish (English transliteration)
✅ **Favorites** - Save and manage favorite songs
✅ **Offline** - All songs stored locally, no internet required
✅ **Dark Mode** - Theme switching support
✅ **Adjustable Font** - Font size customization for readability
✅ **Share** - Share songs via messaging apps
✅ **Material Design 3** - Modern UI with Material You

## Dependencies

### Core
- `flutter` - Flutter framework
- `provider` - State management
- `google_fonts` - Google Fonts integration

### Storage & Persistence
- `shared_preferences` - Local key-value storage
- `hive` - NoSQL database (optional, for advanced caching)
- `hive_flutter` - Hive Flutter integration

### JSON & Serialization
- `json_annotation` - JSON serialization annotations
- `json_serializable` - JSON code generation
- `build_runner` - Code generation tool

### UI & Utilities
- `cupertino_icons` - iOS-style icons
- `intl` - Internationalization
- `uuid` - UUID generation
- `async` - Async utilities
- `share_plus` - Share functionality

## Setup Instructions

### Prerequisites
- Flutter SDK 3.11.1 or higher
- Dart SDK 3.11.1 or higher
- Android Studio or Xcode (for iOS builds)
- Git

### Installation Steps

1. **Clone or extract the project:**
   ```bash
   cd praise_the_lord_flutter
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate code (for JSON serialization):**
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## Building for iOS

### Option 1: Using Flutter Build (Recommended)

```bash
# Build for iOS (creates .app)
flutter build ios

# Build for iOS with release mode
flutter build ios --release

# Build for iOS and create .ipa
flutter build ipa --release
```

### Option 2: Using Xcode

1. Open the iOS project:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. Select your development team in Xcode
3. Configure signing & capabilities
4. Build and archive using Xcode menu

### Option 3: Using fastlane (Advanced)

```bash
# Install fastlane
sudo gem install fastlane

# Initialize fastlane
cd ios
fastlane init

# Build and sign
fastlane build_ios
```

## Building for Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Google Play)
flutter build appbundle --release
```

## Configuration

### App Metadata (pubspec.yaml)
- `name` - App name
- `version` - Version number (format: x.y.z+build)
- `description` - App description

### iOS Configuration (ios/Runner/Info.plist)
- App name
- Bundle identifier
- Supported orientations
- Permissions

### Android Configuration (android/app/build.gradle)
- Package name
- Min/target SDK version
- Permissions

## Troubleshooting

### Issue: Build fails with "Flutter SDK not found"
**Solution:**
```bash
flutter doctor
flutter pub get
flutter clean
flutter pub get
```

### Issue: JSON serialization code not generated
**Solution:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: iOS build fails with certificate errors
**Solution:**
1. Open Xcode: `open ios/Runner.xcworkspace`
2. Select "Runner" project
3. Go to Signing & Capabilities
4. Select your development team
5. Update provisioning profile

### Issue: App crashes on startup
**Solution:**
1. Check logs: `flutter logs`
2. Ensure songs.json is in assets/
3. Verify pubspec.yaml asset configuration
4. Run `flutter clean` and rebuild

## Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/providers/songs_provider_test.dart
```

## Performance Optimization

1. **Lazy Loading** - Load songs on demand for large lists
2. **Image Caching** - Cache app icons and images
3. **Database Indexing** - Use Hive for faster searches
4. **Code Splitting** - Separate UI and business logic

## Deployment

### iOS App Store
1. Create App Store Connect account
2. Create app in App Store Connect
3. Configure signing certificates
4. Build and upload using Xcode or fastlane
5. Submit for review

### Google Play Store
1. Create Google Play Developer account
2. Create app in Google Play Console
3. Build App Bundle (AAB)
4. Upload and configure store listing
5. Submit for review

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Provider Package](https://pub.dev/packages/provider)
- [Material Design 3](https://m3.material.io/)

## Support

For issues or questions:
1. Check Flutter documentation
2. Review error logs: `flutter logs`
3. Run `flutter doctor` for environment issues
4. Check GitHub issues for similar problems

---

**Version:** 1.0.0
**Last Updated:** March 2026
**Flutter SDK:** 3.41.4
**Dart SDK:** 3.11.1
