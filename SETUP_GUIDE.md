# Flutter Development Environment Setup Guide

This guide will help you set up the complete Flutter development environment for the MediQueue project.

## 📋 Prerequisites

- macOS (your current OS)
- At least 10 GB of free disk space
- Stable internet connection
- Admin/sudo access

## 🚀 Step-by-Step Setup

### Step 1: Install Flutter SDK

#### Option A: Using Homebrew (Recommended for macOS)

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Flutter
brew install --cask flutter
```

#### Option B: Manual Installation

```bash
# Download Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add Flutter to PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

#### Verify Installation

```bash
flutter --version
```

Expected output:
```
Flutter 3.x.x • channel stable • https://github.com/flutter/flutter.git
Framework • revision xxxxx
Engine • revision xxxxx
Tools • Dart 3.x.x • DevTools 2.x.x
```

### Step 2: Install Android Studio

1. **Download Android Studio**
   - Visit: https://developer.android.com/studio
   - Download the macOS version
   - Install by dragging to Applications folder

2. **First Launch Setup**
   - Open Android Studio
   - Follow the setup wizard
   - Choose "Standard" installation
   - Wait for SDK components to download

3. **Install JDK 11 or Higher**
   - **Recommended:** Install using Homebrew:
     ```bash
     brew install openjdk@17
     # Link the openjdk to system-wide
     sudo ln -sfn $(brew --prefix)/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
     ```
   - **Manual:** Download from [Oracle](https://www.oracle.com/java/technologies/downloads/) or [Adoptium](https://adoptium.net/)
   - Verify: `java -version` (should be 11 or higher)

4. **Install Flutter & Dart Plugins**
   ```
   Android Studio → Preferences → Plugins
   Search for "Flutter" → Install
   Search for "Dart" → Install (auto-installs with Flutter)
   Restart Android Studio
   ```

5. **Configure Android SDK**
   ```
   Android Studio → Preferences → Appearance & Behavior → System Settings → Android SDK
   
   SDK Platforms Tab:
   ✓ Android 13.0 (Tiramisu) - API Level 33
   ✓ Android 12.0 (S) - API Level 31
   
   SDK Tools Tab:
   ✓ Android SDK Build-Tools
   ✓ Android SDK Command-line Tools
   ✓ Android SDK Platform-Tools
   ✓ Android Emulator
   ✓ Intel x86 Emulator Accelerator (HAXM installer)
   ```

6. **Accept Android Licenses**
   ```bash
   flutter doctor --android-licenses
   # Type 'y' to accept all licenses
   ```

### Step 3: Setup Android Emulator

1. **Open AVD Manager**
   ```
   Android Studio → Tools → Device Manager
   ```

2. **Create Virtual Device**
   - Click "Create Device"
   - Select **Pixel 5** (recommended)
   - Click "Next"

3. **Select System Image**
   - Choose **API Level 33 (Android 13.0 - Tiramisu)**
   - Click "Download" if not already downloaded
   - Click "Next"

4. **Configure AVD**
   - AVD Name: `MediQueue_Emulator`
   - Startup orientation: Portrait
   - Click "Show Advanced Settings"
   - RAM: 2048 MB (minimum)
   - VM heap: 512 MB
   - Internal Storage: 2048 MB
   - SD card: 512 MB
   - Click "Finish"

5. **Enable Hardware Acceleration**
   
   For Intel Macs:
   ```bash
   # Install HAXM
   brew install --cask intel-haxm
   ```
   
   For Apple Silicon (M1/M2/M3):
   ```bash
   # Hardware acceleration is built-in, no additional setup needed
   ```

6. **Launch Emulator**
   - Click the ▶️ play button next to your emulator
   - Wait for it to boot (first time may take 2-3 minutes)

### Step 4: Install Xcode Command Line Tools (macOS)

```bash
xcode-select --install
```

### Step 5: Install CocoaPods (for iOS development)

```bash
sudo gem install cocoapods
```

### Step 6: Run Flutter Doctor

```bash
flutter doctor -v
```

**Expected Output:**
```
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain - develop for Android devices
[✓] Xcode - develop for iOS and macOS
[✓] Chrome - develop for the web
[✓] Android Studio (version 2023.x)
[✓] VS Code (version 1.x.x) [optional]
[✓] Connected device
[✓] Network resources
```

### Step 7: Initialize MediQueue Flutter Project

```bash
# Navigate to project directory
cd S47-0126-S47-Danger-FlutterAndFirebaseStack-MediQueue

# Run the initialization script
./scripts/init_flutter_project.sh
```

## ✅ Verification Checklist

Run the verification script:
```bash
./scripts/verify_setup.sh
```

Manual verification:
- [ ] `flutter --version` shows version 3.0 or higher
- [ ] `flutter doctor` shows all green checkmarks
- [ ] Android Studio recognizes Flutter SDK
- [ ] Android emulator launches successfully
- [ ] Can create and run a test Flutter app
- [ ] Hot reload works (< 1 second)
- [ ] No PATH or permission errors

## 🛠️ Troubleshooting

### Issue: `flutter: command not found`

**Solution:**
```bash
# Add Flutter to PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

### Issue: Android licenses not accepted

**Solution:**
```bash
flutter doctor --android-licenses
# Accept all licenses by typing 'y'
```

### Issue: Emulator won't start

**Solutions:**
1. Check virtualization in BIOS (Intel Macs)
2. Increase RAM allocation in AVD settings
3. Try creating a new emulator with lower API level (31)
4. Restart Android Studio

### Issue: `cmdline-tools component is missing`

**Solution:**
```bash
# In Android Studio:
Preferences → Android SDK → SDK Tools
✓ Check "Android SDK Command-line Tools (latest)"
Click "Apply"
```

### Issue: Gradle build fails

**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

## 📚 Additional Resources

- [Flutter Official Docs](https://docs.flutter.dev)
- [Flutter Installation - macOS](https://docs.flutter.dev/get-started/install/macos)
- [Android Studio Setup](https://developer.android.com/studio)
- [Flutter Doctor](https://docs.flutter.dev/get-started/install/macos#run-flutter-doctor)
- [Flutter Samples](https://flutter.github.io/samples/)

## 🎯 Next Steps

Once your environment is set up:

1. ✅ Verify all checks pass
2. 📱 Run the sample app on emulator
3. 🔥 Test hot reload functionality
4. 📖 Read the [DOCUMENTATION.md](DOCUMENTATION.md)
5. 🏃 Start Sprint 1 tasks from [SPRINT_PLANNING.md](SPRINT_PLANNING.md)

## ⏱️ Estimated Setup Time

- **First-time setup:** 2-3 hours (including downloads)
- **With existing tools:** 30-60 minutes
- **Verification:** 15 minutes

## 💡 Tips

- Use a stable internet connection for downloads
- Don't interrupt SDK downloads
- Restart terminal after PATH changes
- Keep Android Studio updated
- Use Flutter stable channel for production

## 🆘 Getting Help

If you encounter issues:
1. Check the troubleshooting section above
2. Run `flutter doctor -v` for detailed diagnostics
3. Search [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)
4. Ask in [Flutter Discord](https://discord.gg/flutter)
5. Check [Stack Overflow - Flutter](https://stackoverflow.com/questions/tagged/flutter)

---

**Last Updated:** 2026-02-07
**Issue:** [#1 - Setup Flutter SDK, Android Studio & Emulator](https://github.com/kalviumcommunity/S47-0126-S47-Danger-FlutterAndFirebaseStack-MediQueue/issues/1)
