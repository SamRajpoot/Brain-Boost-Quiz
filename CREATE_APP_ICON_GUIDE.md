# Brain Boost Quiz - Create App Icon & Splash Assets

## Quick Path Forward

1. **For testing/demo**: Use online icon generators (5 min)
2. **For professional branding**: Use Figma or Adobe XD (30 min)
3. **For maximum quality**: Hire a designer ($50-200)

## Option 1: Generate Icons Quickly (Recommended for Play Store)

### Using AppIconMaker (Free)

1. Go to [https://www.appiconmaker.com/](https://www.appiconmaker.com/)
2. Upload a 1024x1024px PNG image with your app design
3. Download all generated sizes
4. Extract files to `android/app/src/main/res/`

### Using Online Icon Converter

1. Create or find a brain-themed icon (e.g., from [Noun Project](https://thenounproject.com/))
2. Use [https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html](https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html)
3. Upload your icon, set color to #14B8A6 (teal)
4. Download and extract

## Option 2: Create in Figma (Free)

### Step 1: Design Icon
1. Go to [figma.com](https://figma.com) and create free account
2. New File → Create 1024x1024px artboard
3. Add background circle with color #14B8A6
4. Add brain icon (search "brain" in Figma assets)
5. Add text "Brain Boost" in white, bold font
6. Center everything with 48pt safe margin from edge

### Step 2: Design Splash Screen
1. Create 1080x1920px artboard
2. Add gradient background: Teal (#0EA5A4) → Red (#EF4444) → Dark Blue (#0F172A)
3. Place app icon in center (200x200px)
4. Add "Brain Boost Quiz" text (36pt, white, bold)
5. Add tagline "Sharpen your mind offline" (16pt, white, muted)

### Step 3: Export
1. Select icon artboard
2. Right-click → Export → Set to PNG, 3x scale
3. Download as icon_1024.png
4. Use online tool to generate all sizes

## Option 3: DIY with Python (Advanced)

Use [Pillow](https://python-pillow.org/) to generate icon sizes:

```python
from PIL import Image, ImageDraw, ImageFont
import os

# Create 1024x1024 base icon
img = Image.new('RGBA', (1024, 1024), color=(20, 184, 166, 255))  # Teal background
draw = ImageDraw.Draw(img)

# Add white circle center (brain placeholder)
circle_dia = 600
x0 = (1024 - circle_dia) // 2
y0 = (1024 - circle_dia) // 2
draw.ellipse([x0, y0, x0 + circle_dia, y0 + circle_dia], fill=(255, 255, 255, 255))

# Add text
font = ImageFont.load_default()
text = "Brain Boost"
draw.text((512, 512), text, fill=(20, 184, 166, 255), anchor="mm")

img.save("icon_1024.png")

# Generate smaller sizes
sizes = {
    "xxxhdpi": 192,
    "xxhdpi": 144,
    "xhdpi": 96,
    "hdpi": 72,
    "mdpi": 48
}

for dpi, size in sizes.items():
    resized = img.resize((size, size), Image.Resampling.LANCZOS)
    os.makedirs(f"android/app/src/main/res/mipmap-{dpi}", exist_ok=True)
    resized.save(f"android/app/src/main/res/mipmap-{dpi}/ic_launcher.png")
```

## Manual Icon Placement

After generating icons, place them in:

```
android/app/src/main/res/
├── mipmap-mdpi/
│   └── ic_launcher.png (48x48)
├── mipmap-hdpi/
│   └── ic_launcher.png (72x72)
├── mipmap-xhdpi/
│   └── ic_launcher.png (96x96)
├── mipmap-xxhdpi/
│   └── ic_launcher.png (144x144)
├── mipmap-xxxhdpi/
│   └── ic_launcher.png (192x192)
└── mipmap-anydpi-v26/
    └── ic_launcher.xml (ALREADY CREATED)
```

## Splash Screen Configuration

The splash screen XML has already been created at:
`android/app/src/main/res/drawable/launch_background.xml`

Now you need to add the splash icon image:
1. Create 512x512px PNG with Brain Boost logo
2. Save as `splash_icon.png`
3. Place in `android/app/src/main/res/drawable/`

## Add Flutter Launcher Icons (Optional, Automated)

1. Add to `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: "^0.13.1"

flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icon/icon_1024.png"
  min_sdk_android: 21
```

2. Run:
```bash
flutter pub run flutter_launcher_icons:main
```

This automatically generates all icon sizes!

## Testing Icons Locally

1. Place icon PNG files in above directories
2. Run: `flutter clean && flutter pub get`
3. Build and install: `flutter run`
4. Icon should display on home screen

## Brand Color Reference

Add this to your design/branding guide:

| Element | Color | Hex |
|---------|-------|-----|
| Primary | Teal | #14B8A6 |
| Secondary | Rose | #FB7185 |
| Accent | Amber | #F59E0B |
| Splash Background Start | Dark Teal | #0EA5A4 |
| Splash Background Mid | Navy | #0F172A |
| Splash Background End | Red | #EF4444 |

## Final Verification Checklist

After adding icons:
- [ ] Icon images placed in all mipmap-* folders
- [ ] `ic_launcher.xml` exists in `mipmap-anydpi-v26/`
- [ ] Splash screen icon placed in `drawable/`
- [ ] Colors defined in `values/colors.xml`
- [ ] `flutter clean` completed
- [ ] App starts without icon errors
