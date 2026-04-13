# Play Console Final Checklist (Low Rejection Risk)

Use this file while filling Google Play Console.

## 1) App creation values

- App name: Brain Boost Quiz
- Package name: com.gps.brainboostquiz
- Default language: English (United States) (or keep en-GB, but use one variant consistently in listing text)
- App or game: App
- Free or paid: Free

## 2) Required declarations

- Developer Programme Policies: Accept
- Play App Signing Terms: Accept
- US export laws: Accept

## 3) Store listing text

- Short description:
  Offline quiz challenge with timer, multiple categories, and local high scores.

- Full description:
  Brain Boost Quiz is a fast and fun offline quiz app designed to sharpen your thinking and test your knowledge.

  Play across multiple categories like General Knowledge, Science, Technology, and History. Every question is timed, so each round feels exciting and focused.

  Why you will like it:
  - Fully offline play with bundled quiz content
  - No signup or login required
  - Clean and smooth quiz experience
  - Instant answer feedback
  - Local high scores saved on your device
  - Light and dark theme support

  How it works:
  - Choose a category
  - Answer timed multiple-choice questions
  - See your score and performance level at the end
  - Try again and beat your best local record

  Brain Boost Quiz is great for quick learning sessions, daily brain training, and friendly self-challenges.

## 4) Privacy policy

- Policy URL in Play Console: https://raw.githubusercontent.com/SamRajpoot/Brain-Boost-Quiz/main/PRIVACY_POLICY.md
- In-app policy link: already set in lib/screens/settings_screen.dart
- Must be publicly reachable (no login, no 404, HTTPS valid)
- Must include a real support contact email

## 5) Data Safety (based on current code)

- Does your app collect or share user data? No
- Is all data processed ephemerally? Yes
- Is data encrypted in transit? Not applicable
- Can users request deletion? Not applicable

If you add ads, analytics, crash tools, login, or cloud sync later, update Data Safety before release.

## 6) Ads

- Contains ads? No

## 7) Content rating (IARC)

- App type: Educational quiz
- Violence: None
- Sexual content: None
- Profanity: None
- Controlled substances: None
- Gambling: None
- User-generated content: No
- Shares location: No

## 8) Target audience

- Age groups: 13-17 and 18+
- App appealing to children under 13: No

## 9) Graphics and screenshots

- App icon: 512 x 512 PNG
- Feature graphic: 1024 x 500 PNG
- Phone screenshots: 4 to 8 recommended
- Capture these screens:
  - Splash screen
  - Category selection (home)
  - Quiz question with timer
  - Result screen with score ring
  - Settings + local leaderboard

## 10) Release flow

1. Upload AAB to Internal Testing
2. Add release notes and roll out to internal testers
3. Validate install and full quiz flow
4. Move to Closed/Open testing
5. Submit Production when stable

## 11) Final pass before submit

- Package name matches AAB and listing: com.gps.brainboostquiz
- Privacy policy URL opens in external browser
- No broken screenshots/graphics
- Store text has no misleading claims
- App functions offline end-to-end