# Build and Sign Release AAB for Google Play Store

## Prerequisites

- Flutter SDK installed
- Android SDK installed
- Java JDK installed
- jarsigner and keytool available in PATH

## Step 1: Create Signing Key

If you don't have a keystore file yet, create one:

```bash
keytool -genkey -v -keystore brain_boost_key.jks ^
  -keyalg RSA -keysize 2048 -validity 10000 ^
  -alias brain_boost_key
```

You will be prompted to set:
- Password (remember this!)
- Common Name (CN) - Your Name
- Organization Unit (OU) - e.g., Development
- Organization (O) - Your company
- City, State, Country

**Store this keystore file securely. You'll need it for all future updates.**

## Step 2: Configure Gradle with Key

Create or update `android/key.properties`:

```properties
storePassword=your_password_here
keyPassword=your_password_here
keyAlias=brain_boost_key
storeFile=../brain_boost_key.jks
```

**Important**: Add `android/key.properties` to `.gitignore` to prevent exposing secrets.

## Step 3: Update android/app/build.gradle

Replace the `signingConfigs` section in `android/app/build.gradle`:

```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

## Step 4: Build Signed Release AAB

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

## Step 5: Verify AAB

```bash
bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab ^
  --output=app.apks --ks=brain_boost_key.jks --ks-pass=pass:your_password
```

## Step 6: Upload to Play Console

1. Go to [Google Play Console](https://play.google.com/console)
2. Create new app or select existing
3. Upload AAB to Testing → Internal Testing
4. Fill in app details and screenshots (300-350 char descriptions)
5. Set up store listing with:
   - Short description
   - Full description (4000 char max)
   - Screenshots (2-8 per device type)
   - Feature graphic (1024x500 px)
   - Icon (512x512 px)

## Release Tracks

1. **Internal Testing** - Test with Play Console team only
2. **Closed Testing** - Share with limited tester group (email list)
3. **Open Testing** - Public beta (1% rollout recommended)
4. **Production** - Full public release

## Rolling Out to Production

After 1-2 weeks in each testing track:
1. Increase rollout % (10%, 50%, 100%)
2. Monitor crash reports and ratings
3. Once stable at 100%, promote to Production

## Troubleshooting

**Build fails with "keystore not found":**
- Ensure `android/key.properties` exists
- Check path in `build.gradle` is relative to `android/app/`

**AAB too large:**
- Shrink: `shrinkResources true` in `build.gradle` release config

**APK extracted from AAB won't install:**
- AAB only works via Play Store; use APK for direct testing on device

## Build Commands Cheatsheet

```bash
# Clean build
flutter clean
flutter pub get

# Debug APK (fast, large, not for store)
flutter build apk --debug

# Release APK (for direct device install testing)
flutter build apk --release

# Release AAB (for Play Store - RECOMMENDED)
flutter build appbundle --release

# Split APKs by architecture
flutter build apk --release --split-per-abi
```

## Store Listing Content Ideas

**Short Description (80 char):**
"Challenge your brain with timed offline quizzes!"

**Full Description (4000 char):**
"Brain Boost Quiz is the perfect app to sharpen your mind offline. Test your knowledge across multiple categories including General Knowledge, Science, Technology, and History. Features timed questions, instant feedback, and a local leaderboard to track your progress. No internet required, no login needed – just pure offline learning!"

## Compliance Final Checklist

- [ ] Privacy policy URL set in app
- [ ] No ads or analytics SDKs
- [ ] No login/signup flow
- [ ] All content bundled offline
- [ ] App icon and feature graphic added
- [ ] Screenshots uploaded (2-8)
- [ ] Content rating completed (IARC)
- [ ] App signing key backed up securely
- [ ] Play Store listing filled completely
