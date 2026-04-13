# Brain Boost Quiz (Flutter)

Brain Boost Quiz is a modern offline Android quiz app built with Flutter.

## Features

- Offline quiz categories loaded from local JSON
- Timed MCQ flow (12 seconds per question)
- Animated splash, category cards, question transitions, and result progress ring
- Correct (green) and wrong (red + shake) answer feedback
- Score system with performance levels:
  - 0-3: Beginner
  - 4-7: Intermediate
  - 8-10: Expert
- Local high-score storage with SharedPreferences
- Dark mode + sound toggle settings
- Local-only leaderboard view
- No login/signup

## Architecture

MVVM-inspired clean structure:

- `lib/models` - Data models
- `lib/services` - JSON repository + local storage
- `lib/viewmodels` - UI state/business logic
- `lib/screens` - Screens
- `lib/widgets` - Reusable UI components
- `lib/utils` - Theme and helpers

## Project Structure

```
assets/
  data/quiz_data.json
lib/
  models/
  screens/
  services/
  utils/
  viewmodels/
  widgets/
  app.dart
  main.dart
PRIVACY_POLICY.md
README.md
pubspec.yaml
```

## Setup and Run (Step by Step)

1. Install Flutter SDK (if not already installed) - see [FLUTTER_SETUP.md](FLUTTER_SETUP.md)
2. In terminal, open this project root.
3. Run:

```bash
flutter pub get
flutter run
```

If your machine does not have Android platform folders yet, run:

```bash
flutter create .
flutter pub get
flutter run
```

## Deployment to Google Play Store

**Complete step-by-step guide:** [COMPLETE_DEPLOYMENT_GUIDE.md](COMPLETE_DEPLOYMENT_GUIDE.md)

For production release:
1. Create app icons - [CREATE_APP_ICON_GUIDE.md](CREATE_APP_ICON_GUIDE.md)
2. Build signed release AAB - [BUILD_AND_SIGN.md](BUILD_AND_SIGN.md)
3. Set up Play Console and submit - See **COMPLETE_DEPLOYMENT_GUIDE.md**

## Google Play Compliance Checklist

- No unnecessary permissions used by app logic
- No login/signup flow
- Works fully offline
- Uses local JSON content only
- Privacy policy included in `PRIVACY_POLICY.md`
- Add your hosted privacy policy URL in Play Console and update app setting link in:
  - `lib/screens/settings_screen.dart`

## Notes Before Publishing

- Privacy policy URL: `https://raw.githubusercontent.com/SamRajpoot/Brain-Boost-Quiz/main/PRIVACY_POLICY.md`
- Make sure that URL is publicly reachable before submitting to Google Play
- Add your app icon and splash branding assets
- Configure signing (`key.properties`) for release
- Fill Play Store listing content with original text/images
