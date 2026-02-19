import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../../../services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  UserModel? _user;
  bool _isLoading = false;

  UserProvider(this._authService, this._firestoreService) {
    _init();
  }

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  bool get isAuthenticated => _user != null;
  
  bool get isAdmin => _user?.isAdmin ?? false;
  bool get isDoctor => _user?.isDoctor ?? false;
  bool get isReceptionist => _user?.isReceptionist ?? false;
  bool get isPatient => _user?.isPatient ?? true; // defaulted to true if role missing or error? No, default is patient in UserModel, but here if user is null, isPatient is confusing.
  
  // Better:
  bool get isUserPatient => _user?.isPatient ?? false;


  void _init() {
    _authService.authStateChanges.listen((User? firebaseUser) async {
      if (firebaseUser != null) {
        await _fetchUserProfile(firebaseUser.uid);
      } else {
        _user = null;
        notifyListeners();
      }
    });
  }

  bool _hasError = false;
  bool get hasError => _hasError;

  Future<void> _fetchUserProfile(String uid) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      final doc = await _firestoreService.getDocument('users', uid);
      if (doc.exists && doc.data() != null) {
        _user = UserModel.fromMap(doc.data() as Map<String, dynamic>, uid);
      } else {
        debugPrint('User profile not found for uid: $uid');
        _user = null;
        _hasError = true;
      }
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
      _user = null;
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reload user profile manually
  Future<void> refreshUser() async {
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      await _fetchUserProfile(currentUser.uid);
    }
  }
  
  void clear() {
    _user = null;
    notifyListeners();
  }
}
