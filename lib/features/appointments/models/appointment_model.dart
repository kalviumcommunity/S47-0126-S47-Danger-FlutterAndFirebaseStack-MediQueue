import 'package:cloud_firestore/cloud_firestore.dart';

enum AppointmentStatus { pending, confirmed, cancelled, completed }

class AppointmentModel {
  final String id;
  final String patientId;
  final String doctorId;
  final String doctorName; // Denormalized for simpler display
  final DateTime dateTime;
  final AppointmentStatus status;
  final String reason;
  final DateTime createdAt;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    required this.dateTime,
    this.status = AppointmentStatus.pending,
    this.reason = '',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'dateTime': Timestamp.fromDate(dateTime),
      'status': status.name,
      'reason': reason,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map, String id) {
    return AppointmentModel(
      id: id,
      patientId: map['patientId'] ?? '',
      doctorId: map['doctorId'] ?? '',
      doctorName: map['doctorName'] ?? '',
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      reason: map['reason'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
