# MediQueue - Project Documentation

## 📋 Product Requirements Document (PRD)

This document outlines the technical and functional specifications for MediQueue.

## 🎯 Product Vision

Create a PhonePe-like lightweight platform for OPD queue management that any clinic can adopt in under 5 minutes using just a smartphone and QR code.

## 🏗 High-Level Design (HLD)

### Architecture Overview

```
┌─────────────────────────────────────┐
│      Flutter App (Client)           │
│  ┌──────────┐      ┌──────────┐    │
│  │  Doctor  │      │ Patient  │    │
│  │   App    │      │   App    │    │
│  └──────────┘      └──────────┘    │
└──────────┬──────────────┬───────────┘
           │              │
           ▼              ▼
┌─────────────────────────────────────┐
│         Firebase Services            │
│  ┌────────────────────────────┐    │
│  │  Firebase Authentication   │    │
│  └────────────────────────────┘    │
│  ┌────────────────────────────┐    │
│  │   Cloud Firestore (DB)     │    │
│  └────────────────────────────┘    │
│  ┌────────────────────────────┐    │
│  │    Firebase Storage        │    │
│  └────────────────────────────┘    │
│  ┌────────────────────────────┐    │
│  │    Cloud Functions         │    │
│  └────────────────────────────┘    │
│  ┌────────────────────────────┐    │
│  │  FCM (Notifications)       │    │
│  └────────────────────────────┘    │
└─────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────┐
│      Google Maps SDK                │
└─────────────────────────────────────┘
```

### Main Modules

1. **Authentication Module** - User login/logout, role management
2. **Clinic Management Module** - Clinic setup, doctor management
3. **Queue Management Module** - Token generation, queue operations
4. **Notification Module** - Push notifications, SMS alerts
5. **UI Module** - Screens, widgets, themes
6. **Maps Module** - Location services, navigation
7. **State Management Module** - App state using Provider/Riverpod

## 🧱 Low-Level Design (LLD)

### Core Data Models

#### User
```dart
class User {
  String uid;
  String name;
  String role; // 'doctor' or 'reception'
  String clinicId;
}
```

#### Clinic
```dart
class Clinic {
  String clinicId;
  String name;
  String address;
  GeoPoint location;
  String qrCode;
  DateTime createdAt;
}
```

#### Doctor
```dart
class Doctor {
  String doctorId;
  String clinicId;
  String name;
  String specialization;
  Map<String, String> timing; // day: time slots
}
```

#### QueueToken
```dart
class QueueToken {
  String tokenId;
  String patientName;
  String phone;
  String status; // 'waiting', 'skipped', 'completed'
  int tokenNumber;
  DateTime createdAt;
  String clinicId;
  String doctorId;
}
```

### Services Architecture

#### AuthService
- `signIn(email, password)`
- `signUp(email, password, name, role)`
- `signOut()`
- `getCurrentUser()`
- `checkUserRole()`

#### FirestoreService
- `createClinic(clinic)`
- `getClinic(clinicId)`
- `addDoctor(doctor)`
- `getDoctors(clinicId)`
- `addToken(token)`
- `getQueue(clinicId, doctorId)`
- `updateTokenStatus(tokenId, status)`
- `resetDailyQueue(clinicId)`

#### NotificationService
- `sendPushNotification(userId, message)`
- `sendSMS(phone, message)`
- `scheduleNotification(tokenId, type)`

#### LocationService
- `getCurrentLocation()`
- `getClinicLocation(clinicId)`
- `calculateDistance(from, to)`

#### StorageService
- `uploadQRCode(clinicId, qrImage)`
- `getQRCode(clinicId)`

## 🔄 Data Flow

### Patient Journey
1. Patient scans QR code at clinic
2. Opens web/app screen
3. Enters name + phone number
4. Token generated and added to Firestore
5. Real-time queue position displayed
6. Notifications sent at key events:
   - Queue joined confirmation
   - 2 patients remaining
   - Your turn now

### Doctor/Reception Journey
1. Login with credentials
2. View real-time queue dashboard
3. Call next patient
4. Mark patient as completed/skipped
5. Queue auto-updates for all users

### Queue Management Flow
```
Patient Joins
     ↓
Token Created (Firestore)
     ↓
Queue Updated (Real-time)
     ↓
Notification Triggered (Cloud Function)
     ↓
Patient Notified (FCM/SMS)
     ↓
Doctor Calls Next
     ↓
Token Status Updated
     ↓
Queue Re-synced
```

## 🔐 Security & Privacy

### Firebase Security Rules

#### Firestore Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Clinics
    match /clinics/{clinicId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
                      request.auth.token.clinicId == clinicId;
    }
    
    // Queue Tokens
    match /tokens/{tokenId} {
      allow read: if true; // Public read for patients
      allow write: if request.auth != null;
    }
    
    // Users
    match /users/{userId} {
      allow read: if request.auth.uid == userId;
      allow write: if request.auth.uid == userId;
    }
  }
}
```

### Data Privacy
- No medical records stored
- Only basic patient info (name, phone)
- Data auto-deleted after 24 hours
- HTTPS enforced for all communications
- Role-based access control

## 🎨 Design System

### Color Palette
- Primary: `#2196F3` (Blue)
- Secondary: `#4CAF50` (Green)
- Error: `#F44336` (Red)
- Warning: `#FF9800` (Orange)
- Background Light: `#FFFFFF`
- Background Dark: `#121212`

### Typography
- Heading: Roboto Bold
- Body: Roboto Regular
- Caption: Roboto Light

### Components
- Custom buttons
- Input fields
- Cards
- Bottom navigation
- Dialogs
- Snackbars
- Loading indicators

## 📱 Screen Specifications

### 1. Splash Screen
- App logo
- Loading indicator
- Auto-navigate after auth check

### 2. Login/Signup Screen
- Email input
- Password input
- Role selection (Doctor/Reception)
- Login/Signup toggle

### 3. Clinic Setup Screen
- Clinic name
- Address
- Location picker
- OPD timings
- Generate QR button

### 4. Queue Dashboard
- Current queue list
- Token numbers
- Patient names
- Status indicators
- Next/Skip/Complete buttons
- Add manual entry button

### 5. Patient Join Queue Screen
- Clinic info
- Doctor selection
- Name input
- Phone input
- Join queue button

### 6. Token Status Screen
- Token number (large)
- Current position
- Estimated wait time
- Refresh button

## 🧪 Testing Strategy

### Unit Tests
- Service layer functions
- Data model validation
- Utility functions

### Widget Tests
- UI components
- Screen layouts
- User interactions

### Integration Tests
- End-to-end flows
- Firebase integration
- Navigation flows

### Manual Testing
- Physical device testing
- Network failure scenarios
- Low bandwidth testing
- Edge cases

## 🚀 Deployment Strategy

### Development
- Firebase development project
- Debug builds
- Local testing

### Staging
- Firebase staging project
- Internal testing
- Beta testers

### Production
- Firebase production project
- Play Store release
- Monitoring & analytics

## 📊 Analytics & Monitoring

### Key Metrics to Track
- Daily active users
- Queue completion rate
- Average wait time
- App crashes
- API response times
- User retention

### Tools
- Firebase Analytics
- Firebase Crashlytics
- Firebase Performance Monitoring

## 🔄 CI/CD Pipeline

1. Code commit to GitHub
2. Automated tests run
3. Build APK/App Bundle
4. Deploy to Firebase App Distribution
5. Beta testing
6. Production release

## 📚 API Documentation

### Firestore Collections

#### `/clinics/{clinicId}`
```json
{
  "clinicId": "string",
  "name": "string",
  "address": "string",
  "location": "GeoPoint",
  "qrCode": "string",
  "createdAt": "timestamp"
}
```

#### `/doctors/{doctorId}`
```json
{
  "doctorId": "string",
  "clinicId": "string",
  "name": "string",
  "specialization": "string",
  "timing": {
    "monday": "9:00 AM - 5:00 PM"
  }
}
```

#### `/tokens/{tokenId}`
```json
{
  "tokenId": "string",
  "patientName": "string",
  "phone": "string",
  "status": "waiting|skipped|completed",
  "tokenNumber": "number",
  "createdAt": "timestamp",
  "clinicId": "string",
  "doctorId": "string"
}
```

## 🎯 Success Criteria

- ✅ Clinic onboarding < 10 minutes
- ✅ 60% patients use QR code
- ✅ Reduce waiting time by 30-40%
- ✅ 95%+ app uptime
- ✅ < 3 second load time
- ✅ High doctor adoption rate

## 🔮 Future Enhancements

### Phase 2
- Payment integration
- Appointment booking
- SMS reminders

### Phase 3
- Lab report integration
- Prescription management
- Telemedicine support

### Phase 4
- AI-powered queue optimization
- ABHA integration
- Multi-language support
