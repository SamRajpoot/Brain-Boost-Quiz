# Flutter Development Environment Setup (Windows)

If Flutter is not yet installed on your machine, follow these steps:

## Step 1: Download Flutter SDK

1. Go to [flutter.dev/docs/get-started/install/windows](https://flutter.dev/docs/get-started/install/windows)
2. Download the Flutter SDK (stable branch)
3. Extract to a folder, e.g., `C:\flutter`
4. Add `C:\flutter\bin` to your Windows PATH environment variable

## Step 2: Verify Flutter Installation

```bash
flutter --version
flutter doctor
```

The `flutter doctor` command will check your setup and tell you what's missing (Android SDK, etc).

## Step 3: Install Android Studio (Required)

1. Download from [developer.android.com](https://developer.android.com/studio)
2. Install Android Studio
3. Open Android Studio and go to **SDK Manager** → **SDK Platforms**
4. Install Android 12 and above
5. go to **SDK Tools** and ensure Android SDK Command-line Tools are installed

## Step 4: Accept Android Licenses

```bash
flutter doctor --android-licenses
```

Press `y` to accept all.

## Step 5: Verify All Green

```bash
flutter doctor
```

Expected output (all checks should pass):

```
✓ Flutter (Channel stable)
✓ Android toolchain
✓ Android Studio
✓ Connected device (emulator or phone)
```

## Step 6: Clone or Open Project

```bash
cd "c:\Users\gps\Desktop\Brain Boost Quiz"
flutter pub get
```

## Step 7: Run on Device/Emulator

**On Android Emulator:**
1. Open Android Studio
2. Go to **AVD Manager** → **Create Virtual Device**
3. Select Pixel 5 (or any phone), Android 13+
4. Start the emulator
5. Run: `flutter run`

**On Physical Phone:**
1. Enable USB Debugging: Settings → Developer Options → USB Debugging
2. Connect via USB
3. Run: `flutter run`

## Troubleshooting Setup

**"flutter command not found":**
- Ensure `C:\flutter\bin` is in PATH
- Restart terminal/PowerShell after adding to PATH

**"No Android SDK found":**
- Run Android Studio at least once
- Check `flutter doctor` output for exact missing component

**"Gradle build failed":**
- Try: `flutter clean` then `flutter pub get`
- Check your Internet connection (Gradle downloads large files)

## Next Steps After Setup

Once Flutter is installed:

```bash
cd "c:\Users\gps\Desktop\Brain Boost Quiz"
flutter create .
flutter pub get
flutter run
```

Then follow steps in [BUILD_AND_SIGN.md](BUILD_AND_SIGN.md) for Play Store release.
