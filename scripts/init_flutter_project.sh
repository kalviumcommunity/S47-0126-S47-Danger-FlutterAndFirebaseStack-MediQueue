#!/bin/bash

# MediQueue - Flutter Project Initialization Script
# This script initializes the Flutter project structure for MediQueue

echo "🚀 MediQueue - Flutter Project Initialization"
echo "=============================================="
echo ""

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter is not installed!${NC}"
    echo "Please install Flutter first. See SETUP_GUIDE.md for instructions."
    exit 1
fi

echo -e "${GREEN}✓${NC} Flutter is installed"
echo ""

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -f "DOCUMENTATION.md" ]; then
    echo -e "${RED}❌ Please run this script from the project root directory${NC}"
    exit 1
fi

echo -e "${BLUE}📦 Creating Flutter project structure...${NC}"
echo ""

# Create Flutter project
echo "Creating Flutter app 'mediqueue'..."
flutter create --org com.mediqueue --project-name mediqueue --platforms android,ios .

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to create Flutter project${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} Flutter project created successfully"
echo ""

# Create project directory structure
echo -e "${BLUE}📁 Creating project directory structure...${NC}"

mkdir -p lib/models
mkdir -p lib/screens
mkdir -p lib/widgets
mkdir -p lib/services
mkdir -p lib/providers
mkdir -p lib/utils
mkdir -p lib/constants
mkdir -p lib/config
mkdir -p test/unit
mkdir -p test/widget
mkdir -p test/integration
mkdir -p assets/images
mkdir -p assets/icons
mkdir -p assets/fonts

echo -e "${GREEN}✓${NC} Directory structure created"
echo ""

# Update pubspec.yaml with required dependencies
echo -e "${BLUE}📝 Updating pubspec.yaml with dependencies...${NC}"

cat > pubspec.yaml << 'EOF'
name: mediqueue
description: Lightweight Digital Queue Management for Hospitals - A mobile-first queue & appointment management system for Tier-2/3 hospitals and clinics.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # UI & Design
  cupertino_icons: ^1.0.6
  google_fonts: ^6.1.0
  
  # Firebase
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
  firebase_storage: ^11.6.0
  firebase_messaging: ^14.7.10
  firebase_analytics: ^10.8.0
  firebase_crashlytics: ^3.4.9
  firebase_performance: ^0.9.3+6
  cloud_functions: ^4.6.0
  
  # State Management
  provider: ^6.1.1
  
  # QR Code
  qr_flutter: ^4.1.0
  qr_code_scanner: ^1.0.1
  
  # Maps & Location
  google_maps_flutter: ^2.5.0
  geolocator: ^10.1.0
  geocoding: ^2.1.1
  
  # Utilities
  intl: ^0.18.1
  shared_preferences: ^2.2.2
  path_provider: ^2.1.1
  url_launcher: ^6.2.2
  
  # Networking
  http: ^1.1.2
  dio: ^5.4.0
  
  # Local Notifications
  flutter_local_notifications: ^16.3.0
  
  # Image Handling
  image_picker: ^1.0.7
  cached_network_image: ^3.3.1
  
  # Permissions
  permission_handler: ^11.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  mockito: ^5.4.4
  build_runner: ^2.4.7

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
  
  # fonts:
  #   - family: Roboto
  #     fonts:
  #       - asset: assets/fonts/Roboto-Regular.ttf
  #       - asset: assets/fonts/Roboto-Bold.ttf
  #         weight: 700
EOF

echo -e "${GREEN}✓${NC} pubspec.yaml updated"
echo ""

# Get dependencies
echo -e "${BLUE}📦 Installing dependencies...${NC}"
flutter pub get

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to install dependencies${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} Dependencies installed successfully"
echo ""

# Create .env.example file
echo -e "${BLUE}🔐 Creating environment configuration...${NC}"

cat > .env.example << 'EOF'
# Firebase Configuration
FIREBASE_API_KEY=your_api_key_here
FIREBASE_APP_ID=your_app_id_here
FIREBASE_MESSAGING_SENDER_ID=your_sender_id_here
FIREBASE_PROJECT_ID=your_project_id_here
FIREBASE_STORAGE_BUCKET=your_storage_bucket_here

# Google Maps API
GOOGLE_MAPS_API_KEY=your_google_maps_api_key_here

# Environment
ENVIRONMENT=development
EOF

echo -e "${GREEN}✓${NC} .env.example created"
echo ""

# Create README for scripts
cat > scripts/README.md << 'EOF'
# MediQueue Scripts

This directory contains helper scripts for the MediQueue project.

## Available Scripts

### `verify_setup.sh`
Verifies that your Flutter development environment is properly configured.

```bash
./scripts/verify_setup.sh
```

### `init_flutter_project.sh`
Initializes the Flutter project structure with all necessary directories and dependencies.

```bash
./scripts/init_flutter_project.sh
```

## Making Scripts Executable

If you get a "permission denied" error, make the scripts executable:

```bash
chmod +x scripts/*.sh
```
EOF

echo -e "${GREEN}✓${NC} Scripts README created"
echo ""

# Make scripts executable
chmod +x scripts/*.sh

echo "=============================================="
echo -e "${GREEN}🎉 Flutter project initialized successfully!${NC}"
echo "=============================================="
echo ""
echo "📁 Project structure:"
echo "  lib/"
echo "    ├── models/       - Data models"
echo "    ├── screens/      - UI screens"
echo "    ├── widgets/      - Reusable widgets"
echo "    ├── services/     - Business logic & API"
echo "    ├── providers/    - State management"
echo "    ├── utils/        - Utility functions"
echo "    ├── constants/    - App constants"
echo "    └── config/       - Configuration files"
echo ""
echo "📝 Next steps:"
echo "  1. Configure Firebase (see DOCUMENTATION.md)"
echo "  2. Copy .env.example to .env and add your keys"
echo "  3. Run: flutter run (to test on emulator)"
echo "  4. Start Sprint 1 tasks (see SPRINT_PLANNING.md)"
echo ""
echo "🔍 Verify everything is working:"
echo "  flutter doctor -v"
echo "  flutter analyze"
echo "  flutter test"
echo ""
