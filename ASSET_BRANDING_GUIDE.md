# Brain Boost Quiz - Asset Branding Guide

## App Icon & Splash Assets

This guide helps you create branded app icons and splash screens for Play Store.

### Quick Start with flutter_launcher_icons

1. Add to `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: "^0.13.1"

flutter_icons:
  android: "launcher_icon"
  image_path: "assets/icon/icon_1024.png"
  min_sdk_android: 21
```

2. Generate icons:

```bash
flutter pub run flutter_launcher_icons:main
```

### Manual Icon Setup

Android launcher icons go in: `android/app/src/main/res/mipmap-*`

Required sizes:

| Size | Path | DPI |
|------|------|-----|
| 192px | mipmap-xxxhdpi | 3x |
| 144px | mipmap-xxhdpi | 2x |
| 96px | mipmap-xhdpi | 1x |
| 72px | mipmap-hdpi | 0.75x |
| 48px | mipmap-mdpi | 0.5x |

### Splash Screen

Flutter now uses adaptive splash by default. To customize:

Edit `android/app/src/main/AndroidManifest.xml` and add:

```xml
<meta-data
    android:name="io.flutter.embedding.android.SplashScreenDrawable"
    android:resource="@drawable/launch_background" />
```

Place custom splash drawable in: `android/app/src/main/res/drawable/launch_background.xml`

### Recommended Brand Colors

- **Primary**: #14B8A6 (Teal)
- **Secondary**: #FB7185 (Rose)
- **Accent**: #F59E0B (Amber)

### Design Tips

- Keep safe margin of 48pt around icon center
- Icon should be rounded for Android 12+ adaptive icon
- Splash should complement app color gradient (Teal → Red)
- Ensure 3x resolution PNG for best quality

### Creating Assets in Figma (Free)

1. Create 1024x1024px artboard
2. Design app icon with Brain icon + text "Brain Boost"
3. Export as PNG at 3x resolution (1024px)
4. Use online tool to generate all sizes ([https://www.appiconmaker.com/](https://www.appiconmaker.com/))

### Quick PNG Icon Template (Base64 Placeholder)

For testing, you can use a simple gradient icon placeholder. Replace manually with your branded PNG.

## After Adding Assets

1. Run: `flutter clean`
2. Run: `flutter pub get`
3. Build: `flutter build apk --release`
