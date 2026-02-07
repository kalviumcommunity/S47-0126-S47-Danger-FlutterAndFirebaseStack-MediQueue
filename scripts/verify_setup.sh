#!/bin/bash

# MediQueue - Flutter Environment Verification Script
# This script checks if your Flutter development environment is properly configured

echo "🔍 MediQueue - Flutter Environment Verification"
echo "================================================"
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
PASSED=0
FAILED=0
WARNINGS=0

# Function to print success
print_success() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED++))
}

# Function to print failure
print_failure() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED++))
}

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

echo "1️⃣  Checking Flutter Installation..."
if command -v flutter &> /dev/null; then
    FLUTTER_VERSION=$(flutter --version | head -n 1)
    print_success "Flutter is installed: $FLUTTER_VERSION"
else
    print_failure "Flutter is not installed"
    echo "   → Install Flutter: https://docs.flutter.dev/get-started/install"
fi
echo ""

echo "2️⃣  Checking Dart Installation..."
if command -v dart &> /dev/null; then
    DART_VERSION=$(dart --version 2>&1 | head -n 1)
    print_success "Dart is installed: $DART_VERSION"
else
    print_failure "Dart is not installed (comes with Flutter)"
fi
echo ""

echo "3️⃣  Checking Android Studio..."
if [ -d "/Applications/Android Studio.app" ]; then
    print_success "Android Studio is installed"
else
    print_warning "Android Studio not found in /Applications"
    echo "   → Install from: https://developer.android.com/studio"
fi
echo ""

echo "4️⃣  Checking JDK Installation..."
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | head -n 1)
    echo "   Current: $JAVA_VERSION"
    
    # Extract major version
    VERSION_MAJOR=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
    # Handle cases like "1.8.x"
    if [ "$VERSION_MAJOR" = "1" ]; then
        VERSION_MAJOR=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f2)
    fi

    if [ "$VERSION_MAJOR" -ge 11 ]; then
        print_success "JDK 11+ is installed (Version: $VERSION_MAJOR)"
    else
        print_failure "JDK version is too old (found $VERSION_MAJOR, need 11+)"
        echo "   → Install JDK 11+: brew install openjdk@17"
    fi
else
    print_failure "JDK is not installed"
    echo "   → Install JDK 11+: brew install openjdk@17"
fi
echo ""

echo "5️⃣  Checking Android SDK..."
if [ -n "$ANDROID_HOME" ] || [ -n "$ANDROID_SDK_ROOT" ]; then
    print_success "Android SDK path is configured"
else
    print_warning "ANDROID_HOME or ANDROID_SDK_ROOT not set"
    echo "   → Configure in Android Studio or set environment variable"
fi
echo ""

echo "6️⃣  Checking Xcode Command Line Tools..."
if xcode-select -p &> /dev/null; then
    print_success "Xcode Command Line Tools are installed"
else
    print_warning "Xcode Command Line Tools not found"
    echo "   → Install with: xcode-select --install"
fi
echo ""

echo "7️⃣  Checking CocoaPods..."
if command -v pod &> /dev/null; then
    POD_VERSION=$(pod --version)
    print_success "CocoaPods is installed: $POD_VERSION"
else
    print_warning "CocoaPods not installed (needed for iOS)"
    echo "   → Install with: sudo gem install cocoapods"
fi
echo ""

echo "8️⃣  Running Flutter Doctor..."
echo "-------------------------------------------"
if command -v flutter &> /dev/null; then
    flutter doctor
    echo "-------------------------------------------"
    
    # Check if flutter doctor passes
    if flutter doctor | grep -q "No issues found!"; then
        print_success "Flutter doctor passed with no issues"
    else
        print_warning "Flutter doctor found some issues (see above)"
    fi
else
    print_failure "Cannot run flutter doctor - Flutter not installed"
fi
echo ""

echo "9️⃣  Checking for Android Emulator..."
if command -v flutter &> /dev/null; then
    DEVICES=$(flutter devices 2>&1)
    if echo "$DEVICES" | grep -q "emulator"; then
        print_success "Android emulator is available"
    else
        print_warning "No Android emulator found"
        echo "   → Create one in Android Studio → Tools → Device Manager"
    fi
else
    print_warning "Cannot check emulators - Flutter not installed"
fi
echo ""

echo "🔟  Checking Project Dependencies..."
if [ -f "pubspec.yaml" ]; then
    print_success "pubspec.yaml found"
    
    if [ -d ".dart_tool" ] && [ -f "pubspec.lock" ]; then
        print_success "Dependencies are installed"
    else
        print_warning "Dependencies not installed"
        echo "   → Run: flutter pub get"
    fi
else
    print_warning "pubspec.yaml not found - Flutter project not initialized yet"
    echo "   → Run: ./scripts/init_flutter_project.sh"
fi
echo ""

echo "1️⃣1️⃣  Checking Git Configuration..."
if command -v git &> /dev/null; then
    print_success "Git is installed"
    
    if git config user.name &> /dev/null && git config user.email &> /dev/null; then
        print_success "Git is configured"
    else
        print_warning "Git user not configured"
        echo "   → Run: git config --global user.name 'Your Name'"
        echo "   → Run: git config --global user.email 'your@email.com'"
    fi
else
    print_failure "Git is not installed"
fi
echo ""

# Summary
echo "================================================"
echo "📊 Verification Summary"
echo "================================================"
echo -e "${GREEN}Passed:${NC}   $PASSED"
echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
echo -e "${RED}Failed:${NC}   $FAILED"
echo ""

if [ $FAILED -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}🎉 Perfect! Your environment is fully configured!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Initialize Flutter project: ./scripts/init_flutter_project.sh"
    echo "  2. Start coding! Check SPRINT_PLANNING.md for tasks"
    exit 0
elif [ $FAILED -eq 0 ]; then
    echo -e "${YELLOW}⚠️  Your environment is mostly ready, but has some warnings.${NC}"
    echo "   Review the warnings above and fix them if needed."
    exit 0
else
    echo -e "${RED}❌ Your environment has critical issues.${NC}"
    echo "   Please fix the failed checks above."
    echo "   Refer to SETUP_GUIDE.md for detailed instructions."
    exit 1
fi
