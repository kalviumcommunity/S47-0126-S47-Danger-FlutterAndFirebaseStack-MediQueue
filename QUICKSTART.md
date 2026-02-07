# Quick Start Guide - MediQueue

Get up and running with MediQueue in minutes!

## 🚀 For New Developers

### Step 1: Install Flutter (if not already installed)

**macOS (Recommended):**
```bash
# Using Homebrew
brew install --cask flutter

# OR Manual installation
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

### Step 2: Verify Your Setup

```bash
./scripts/verify_setup.sh
```

This will check:
- ✅ Flutter installation
- ✅ Android Studio
- ✅ Android SDK
- ✅ Emulator availability
- ✅ All dependencies

### Step 3: Initialize the Flutter Project

```bash
./scripts/init_flutter_project.sh
```

This will:
- Create Flutter project structure
- Install all dependencies
- Set up directory organization
- Create configuration files

### Step 4: Run the App

```bash
# Start an emulator first (in Android Studio)
# Then run:
flutter run
```

## 📱 For Existing Team Members

If you're joining an existing project:

```bash
# 1. Clone the repository
git clone https://github.com/kalviumcommunity/S47-0126-S47-Danger-FlutterAndFirebaseStack-MediQueue.git
cd S47-0126-S47-Danger-FlutterAndFirebaseStack-MediQueue

# 2. Verify your environment
./scripts/verify_setup.sh

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

## 🔧 Common Commands

### Development
```bash
# Run on emulator
flutter run

# Run with hot reload
flutter run --hot

# Run in debug mode
flutter run --debug

# Run in release mode
flutter run --release

# Run on specific device
flutter devices
flutter run -d <device-id>
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/auth_test.dart

# Run with coverage
flutter test --coverage
```

### Code Quality
```bash
# Analyze code
flutter analyze

# Format code
flutter format lib/

# Check for outdated packages
flutter pub outdated
```

### Build
```bash
# Build APK
flutter build apk

# Build App Bundle (for Play Store)
flutter build appbundle

# Build for iOS
flutter build ios
```

### Clean & Rebuild
```bash
# Clean build files
flutter clean

# Get dependencies
flutter pub get

# Rebuild
flutter run
```

## 🐛 Troubleshooting

### "Flutter command not found"
```bash
# Add Flutter to PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

### "Android licenses not accepted"
```bash
flutter doctor --android-licenses
# Type 'y' to accept all
```

### "Gradle build failed"
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### "No devices found"
```bash
# Start an emulator in Android Studio
# OR
flutter emulators
flutter emulators --launch <emulator-id>
```

## 📚 Documentation

- **[SETUP_GUIDE.md](SETUP_GUIDE.md)** - Detailed setup instructions
- **[DOCUMENTATION.md](DOCUMENTATION.md)** - Technical architecture
- **[SPRINT_PLANNING.md](SPRINT_PLANNING.md)** - Development roadmap
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Contribution guidelines

## 🎯 Next Steps

1. ✅ Complete environment setup
2. 📖 Read the [DOCUMENTATION.md](DOCUMENTATION.md)
3. 🏃 Check [SPRINT_PLANNING.md](SPRINT_PLANNING.md) for current tasks
4. 💻 Start coding!
5. 🔄 Create PR for your changes

## 💡 Pro Tips

- Use `flutter doctor -v` to diagnose issues
- Enable hot reload for faster development
- Use `flutter analyze` before committing
- Run tests with `flutter test`
- Keep dependencies updated

## 🆘 Need Help?

- Check [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed instructions
- Run `./scripts/verify_setup.sh` to diagnose issues
- Review [Flutter Documentation](https://docs.flutter.dev)
- Ask in project discussions

---

**Happy Coding! 🚀**
