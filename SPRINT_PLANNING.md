# MediQueue - Sprint Planning

## 🎯 Sprint Overview

This document outlines the 4-sprint roadmap for building MediQueue MVP.

---

## 📅 Sprint 1: Foundation & UI (Week 1-2)

### Goals
- Set up Flutter project structure
- Create all UI screens
- Implement navigation
- Design theme system

### Tasks

#### 1.1 Project Setup
- [ ] Initialize Flutter project
- [ ] Set up folder structure (lib/screens, lib/widgets, lib/services, lib/models)
- [ ] Configure pubspec.yaml with dependencies
- [ ] Set up Git repository
- [ ] Create development branch

#### 1.2 Theme & Design System
- [ ] Create `theme.dart` with color palette
- [ ] Define text styles
- [ ] Create dark mode theme
- [ ] Set up responsive utilities

#### 1.3 UI Screens (Static)
- [ ] Splash Screen
- [ ] Login/Signup Screen
- [ ] Clinic Setup Screen
- [ ] Doctor List Screen
- [ ] QR Code Display Screen
- [ ] Patient Join Queue Screen
- [ ] Queue Dashboard Screen
- [ ] Token Status Screen
- [ ] Map Screen (placeholder)
- [ ] Settings Screen

#### 1.4 Navigation
- [ ] Set up named routes
- [ ] Implement bottom navigation
- [ ] Add drawer navigation
- [ ] Create navigation service

#### 1.5 Reusable Widgets
- [ ] Custom Button
- [ ] Custom TextField
- [ ] Custom Card
- [ ] Loading Indicator
- [ ] Empty State Widget
- [ ] Error Widget

### Deliverables
- ✅ Complete UI mockup in Flutter
- ✅ Working navigation between screens
- ✅ Consistent theme applied
- ✅ Responsive layouts

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  google_fonts: ^6.1.0
```

---

## 📅 Sprint 2: Firebase Integration & Core Logic (Week 3-4)

### Goals
- Integrate Firebase Authentication
- Set up Cloud Firestore
- Implement CRUD operations for queue management
- Add state management

### Tasks

#### 2.1 Firebase Setup
- [ ] Create Firebase project
- [ ] Add Android app to Firebase
- [ ] Add iOS app to Firebase (optional)
- [ ] Download and configure `google-services.json`
- [ ] Install Firebase packages
- [ ] Initialize Firebase in app

#### 2.2 Authentication Module
- [ ] Create AuthService
- [ ] Implement email/password signup
- [ ] Implement email/password login
- [ ] Implement logout
- [ ] Add session persistence
- [ ] Create role-based access (Doctor/Reception)

#### 2.3 Data Models
- [ ] Create User model
- [ ] Create Clinic model
- [ ] Create Doctor model
- [ ] Create QueueToken model
- [ ] Add JSON serialization

#### 2.4 Firestore Service
- [ ] Create FirestoreService
- [ ] Implement createClinic()
- [ ] Implement getClinic()
- [ ] Implement addDoctor()
- [ ] Implement getDoctors()
- [ ] Implement addToken()
- [ ] Implement getQueue()
- [ ] Implement updateTokenStatus()
- [ ] Implement resetDailyQueue()

#### 2.5 State Management
- [ ] Set up Provider/Riverpod
- [ ] Create AuthProvider
- [ ] Create ClinicProvider
- [ ] Create QueueProvider
- [ ] Implement real-time listeners

#### 2.6 Queue Logic
- [ ] Token number generation
- [ ] Queue position calculation
- [ ] Estimated wait time algorithm
- [ ] Next/Skip/Complete logic
- [ ] Daily queue reset

### Deliverables
- ✅ Working authentication flow
- ✅ Firestore CRUD operations
- ✅ Real-time queue updates
- ✅ State management implemented

### Dependencies
```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
  provider: ^6.1.1
  # OR
  flutter_riverpod: ^2.4.9
```

---

## 📅 Sprint 3: Advanced Features (Week 5-6)

### Goals
- Implement push notifications
- Add Google Maps integration
- Create Cloud Functions
- Implement QR code generation
- Testing

### Tasks

#### 3.1 Notifications
- [ ] Set up Firebase Cloud Messaging
- [ ] Request notification permissions
- [ ] Implement FCM token management
- [ ] Create NotificationService
- [ ] Send notification on queue join
- [ ] Send notification when 2 patients remaining
- [ ] Send notification for patient's turn
- [ ] Add local notifications

#### 3.2 QR Code
- [ ] Generate QR code for clinic
- [ ] Display QR code on screen
- [ ] Implement QR scanner (optional)
- [ ] Store QR in Firebase Storage
- [ ] Add download QR option

#### 3.3 Google Maps Integration
- [ ] Set up Google Maps API key
- [ ] Add maps package
- [ ] Display clinic location on map
- [ ] Implement location picker
- [ ] Add navigation to clinic
- [ ] Calculate distance

#### 3.4 Cloud Functions
- [ ] Set up Cloud Functions project
- [ ] Create function for notification triggers
- [ ] Create function for daily queue reset
- [ ] Create function for wait time calculation
- [ ] Deploy functions

#### 3.5 Testing
- [ ] Write unit tests for services
- [ ] Write widget tests for screens
- [ ] Write integration tests
- [ ] Test on physical devices
- [ ] Test offline scenarios
- [ ] Test low bandwidth scenarios

### Deliverables
- ✅ Push notifications working
- ✅ QR code generation
- ✅ Maps integration
- ✅ Cloud Functions deployed
- ✅ Test coverage > 70%

### Dependencies
```yaml
dependencies:
  firebase_messaging: ^14.7.10
  firebase_storage: ^11.6.0
  qr_flutter: ^4.1.0
  google_maps_flutter: ^2.5.0
  geolocator: ^10.1.0
  cloud_functions: ^4.6.0
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
```

---

## 📅 Sprint 4: Deployment & Polish (Week 7-8)

### Goals
- Bug fixes and optimization
- User feedback integration
- Play Store deployment
- Documentation
- Monitoring setup

### Tasks

#### 4.1 Bug Fixes & Optimization
- [ ] Fix reported bugs
- [ ] Optimize app performance
- [ ] Reduce app size
- [ ] Improve load times
- [ ] Handle edge cases
- [ ] Add error boundaries

#### 4.2 UI/UX Polish
- [ ] Add animations
- [ ] Improve transitions
- [ ] Add haptic feedback
- [ ] Improve accessibility
- [ ] Add loading states
- [ ] Add empty states
- [ ] Add error states

#### 4.3 Security
- [ ] Implement Firestore security rules
- [ ] Add input validation
- [ ] Sanitize user inputs
- [ ] Add rate limiting
- [ ] Secure API keys

#### 4.4 Analytics & Monitoring
- [ ] Set up Firebase Analytics
- [ ] Set up Crashlytics
- [ ] Add performance monitoring
- [ ] Track key user events
- [ ] Create analytics dashboard

#### 4.5 Documentation
- [ ] Update README
- [ ] Create API documentation
- [ ] Write user guide
- [ ] Create admin guide
- [ ] Document deployment process

#### 4.6 Deployment
- [ ] Create app icon
- [ ] Create splash screen
- [ ] Generate signed APK
- [ ] Create Play Store listing
- [ ] Upload screenshots
- [ ] Write app description
- [ ] Submit for review
- [ ] Deploy to Play Store

#### 4.7 Feedback & Iteration
- [ ] Collect user feedback
- [ ] Prioritize improvements
- [ ] Implement quick fixes
- [ ] Plan next iteration

### Deliverables
- ✅ Production-ready app
- ✅ Play Store published
- ✅ Complete documentation
- ✅ Monitoring active
- ✅ Feedback collected

### Dependencies
```yaml
dependencies:
  firebase_analytics: ^10.8.0
  firebase_crashlytics: ^3.4.9
  firebase_performance: ^0.9.3+6
```

---

## 📊 Definition of Done

### For Each Sprint
- [ ] All tasks completed
- [ ] Code reviewed
- [ ] Tests passing
- [ ] Documentation updated
- [ ] Demo prepared
- [ ] Sprint retrospective completed

### For MVP Release
- [ ] All features working
- [ ] No critical bugs
- [ ] Performance acceptable
- [ ] Security audit passed
- [ ] User testing completed
- [ ] Play Store approved

---

## 🎯 Success Metrics

### Sprint 1
- All UI screens created
- Navigation working smoothly
- Theme consistent across app

### Sprint 2
- Authentication working
- Queue CRUD operations functional
- Real-time updates working

### Sprint 3
- Notifications delivered
- Maps showing locations
- QR codes generated

### Sprint 4
- App on Play Store
- < 5 critical bugs
- Positive user feedback

---

## 🚀 Post-MVP Roadmap

### Phase 2 (Month 3-4)
- Appointment booking
- Payment integration
- SMS notifications
- Multi-language support

### Phase 3 (Month 5-6)
- Lab reports
- Prescription management
- Analytics dashboard
- Admin panel

### Phase 4 (Month 7+)
- Telemedicine
- AI queue optimization
- ABHA integration
- iOS app

---

## 📝 Notes

- Each sprint is 2 weeks
- Daily standups recommended
- Weekly sprint reviews
- Adjust timeline based on team size
- Prioritize MVP features first
- Keep scope flexible

---

**Last Updated:** 2026-02-07
