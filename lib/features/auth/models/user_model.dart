enum UserRole {
  admin,
  doctor,
  receptionist,
  patient, // default
}

class UserModel {
  final String uid;
  final String name;
  final UserRole role; // Changed from String to UserRole
  final String clinicId;
  final String email;

  UserModel({
    required this.uid,
    required this.name,
    required this.role,
    required this.clinicId,
    required this.email,
  });

  bool get isAdmin => role == UserRole.admin;
  bool get isDoctor => role == UserRole.doctor;
  bool get isReceptionist => role == UserRole.receptionist;
  bool get isPatient => role == UserRole.patient;

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      role: _parseRole(map['role']),
      clinicId: map['clinicId'] ?? '',
      email: map['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'role': role.name, // saves 'admin', 'doctor', etc.
      'clinicId': clinicId,
      'email': email,
    };
  }

  static UserRole _parseRole(String? roleString) {
    if (roleString == null) return UserRole.patient;
    try {
      return UserRole.values.firstWhere(
        (e) => e.name == roleString,
        orElse: () => UserRole.patient,
      );
    } catch (_) {
      return UserRole.patient;
    }
  }
}
