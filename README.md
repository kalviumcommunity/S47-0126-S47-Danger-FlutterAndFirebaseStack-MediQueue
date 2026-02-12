## 🧩 Widget Rebuild Demo

This project includes an interactive demonstration screen to help the team understand Flutter's reactive UI model and widget rebuilds.

### How to Use
- Navigate to `/widget-demo` route in the app (see `app_routes.dart`).
- Try the counter, color picker, text input, and toggles.
- Watch widgets flash when they rebuild and check the rebuild count.
- Open the console to see rebuild logs with timestamps.
- Use Flutter DevTools to inspect the widget tree.

### Learning Outcomes
- How `setState()` triggers build()
- Why only changed widgets rebuild (when optimized)
- The importance of `const` constructors
- When to split widgets for performance

### Performance Tips
- Use `const` constructors where possible.
- Split widgets to minimize rebuilds.
- Avoid unnecessary `setState` calls.
- Use Flutter DevTools to inspect widget tree.

---
## 🗂️ Project Structure & Architecture

MediQueue is a modular Flutter app following clean architecture principles. The folder structure is designed for scalability, maintainability, and ease of onboarding new developers.

### Folder Structure
```
lib/
├── main.dart                 # App entry point
├── app.dart                  # MaterialApp configuration
├── core/                     # Core functionality
│   ├── constants/           # App-wide constants
│   ├── theme/               # Theme configuration
│   ├── utils/               # Helper functions
│   └── config/              # App configuration
├── features/                 # Feature-based modules
│   ├── auth/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── models/
│   │   └── services/
│   ├── queue/
│   └── dashboard/
├── shared/                   # Shared across features
│   ├── widgets/             # Reusable widgets
│   ├── models/              # Common data models
│   └── services/            # Shared services
└── routes/                   # Navigation & routing
assets/
├── images/
│   ├── logo/
│   ├── icons/
│   └── illustrations/
├── fonts/
│   └── Roboto/
└── data/
   └── mock_data.json
```

### Principles
- **Feature-first:** Group by feature, not by type
- **Separation of concerns:** UI, logic, and data are separate
- **Scalability:** Easy to add new features
- **Testability:** Clear boundaries for unit tests

### Example Files
- `main.dart`: Clean entry point (<50 lines)
- `app.dart`: App configuration
- `core/constants/app_constants.dart`: App-wide constants
- `features/auth/screens/login_screen.dart`: Example screen
- `shared/widgets/custom_button.dart`: Reusable widget
- `assets/data/mock_data.json`: Example mock data

### Best Practices
- One widget per file (for complex widgets)
- Barrel exports (`index.dart`) for each module
- Consistent naming conventions
- Shared code goes in `shared/`, not `core/`

### Getting Started
1. Clone the repo
2. Run `flutter pub get`
3. Start coding!

---
For more details, see ARCHITECTURE.md and CONTRIBUTING.md.
# MediQueue - Lightweight Digital Queue Management for Hospitals

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 🏥 Overview

MediQueue is a **PhonePe-like lightweight platform** for OPD queue management designed specifically for Tier-2/3 hospitals and clinics. It enables any clinic to adopt digital queue management in under 5 minutes using just a smartphone and QR code.

## 🎯 Problem Statement

In Tier-2/3 cities:
- ❌ Patients wait in long physical queues
- ❌ No transparency of waiting time
- ❌ Manual registers cause inefficiency
- ❌ Hospitals can't afford heavy HIS software
- ❌ Poor internet reliability

## ✨ Solution

MediQueue provides:
- ✅ QR-based patient onboarding
- ✅ Real-time queue updates
- ✅ Push notifications
- ✅ Simple admin panel for doctors/reception
- ✅ Works on low bandwidth
- ✅ No expensive hardware required

## 🚀 Key Features (MVP)

### 1. Authentication (Firebase Auth)
- Email & password login for staff
- Session persistence
- Role-based access (Doctor / Reception)

### 2. Clinic Setup Module
- Create clinic profile
- Add doctors
- Set OPD timings
- Generate QR code

### 3. Patient Queue Module
- Scan QR code
- Enter name + phone
- Join queue
- Get token number
- View estimated wait time

### 4. Queue Management Dashboard
- View current queue
- Next / Skip / Complete patient
- Manual patient entry
- Reset daily queue

### 5. Notifications
- SMS / Push notifications
- Events: Queue joined, 2 patients remaining, Turn now

### 6. Real-time Sync (Firestore)
- Live updates across devices
- Snapshot listeners

### 7. Maps & Location (Optional MVP+)
- Show clinic location
- Patient navigation

## 🛠 Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Storage
  - Firebase Cloud Messaging (FCM)
  - Cloud Functions
- **Design:** Figma
- **Maps & Location:** Google Maps SDK
- **State Management:** Provider / Riverpod

## 📊 Success Metrics

- Clinic onboarding < 10 minutes
- 60% patients use QR
- Reduce waiting time by 30–40%
- High doctor adoption rate
- App stability

## 🎨 UI Screens

1. Splash Screen
2. Login / Signup
3. Clinic Setup Screen
4. Doctor List Screen
5. QR Code Screen
6. Patient Join Queue Screen
7. Queue Dashboard
8. Token Status Screen
9. Map Screen
10. Settings Screen

## 🏗 Architecture

```
Flutter App (Client)
    ⬇
Firebase Authentication
Cloud Firestore (DB)
Firebase Storage
Cloud Functions
FCM (Notifications)
Google Maps SDK
```

### Main Modules
1. Authentication Module
2. Clinic Management Module
3. Queue Management Module
4. Notification Module
5. UI Module
6. Maps Module
7. State Management Module

## 🔐 Security

- Firebase Authentication
- Firestore rules by clinicId
- No medical records stored
- Data auto-delete after 24 hours
- HTTPS enforced

## 📅 Project Roadmap

### Sprint 1
- Flutter setup
- UI screens
- Navigation
- Theme

### Sprint 2
- Firebase Auth
- Firestore integration
- CRUD queue flow

### Sprint 3
- Notifications
- Maps
- Cloud Functions
- Testing

### Sprint 4
- Deployment
- Feedback
- Iteration

## 🚫 Out of Scope (Future Features)

- Payments
- EMR (Electronic Medical Records)
- Insurance
- Lab reports
- AI diagnosis
- Video consultation
- ABHA integration

## 🧪 Testing

- Emulator testing
- Physical device testing
- Error handling
- Empty states
- Network failure cases

## 📦 Installation

### Prerequisites
- Flutter SDK (3.0+)
- Dart SDK
- Firebase CLI
- Android Studio / VS Code
- Git

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/kalviumcommunity/S47-0126-S47-Danger-FlutterAndFirebaseStack-MediQueue.git
   cd S47-0126-S47-Danger-FlutterAndFirebaseStack-MediQueue
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project
   - Add Android/iOS apps
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in respective directories

4. **Run the app**
   ```bash
   flutter run
   ```

## 🚀 Deployment

- Build APK/App Bundle
- Play Store deployment
- Firebase production environment
- Monitoring logs & crashes

## 👥 Target Users

### Primary Users
- Doctors
- Receptionists
- Small clinics
- Diagnostic centers

### Secondary Users
- Patients (smartphone users)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Contact

For questions or support, please open an issue on GitHub.

---

**Made with ❤️ for Tier-2/3 Healthcare**
