import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';

class QueueEntry {
  final String id;
  final String patientId;
  final String token;
  final String doctorId;
  final String status;
  final String createdAt;
  final String updatedAt;

  QueueEntry({
    required this.id,
    required this.patientId,
    required this.token,
    required this.doctorId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QueueEntry.fromJson(Map<String, dynamic> json, String id) => QueueEntry(
    id: id,
    patientId: json['patient_id'] as String? ?? '',
    token: json['token'] as String? ?? '',
    doctorId: json['doctor_id'] as String? ?? '',
    status: json['status'] as String? ?? 'waiting',
    createdAt: json['created_at'] as String? ?? '',
    updatedAt: json['updated_at'] as String? ?? '',
  );

  factory QueueEntry.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return QueueEntry.fromJson(data, snapshot.id);
  }

  Map<String, dynamic> toJson() => {
    'patient_id': patientId,
    'token': token,
    'doctor_id': doctorId,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class QueueRepository {
  final FirestoreService _firestoreService = FirestoreService();
  final String _collection = 'queue';

  // Add a new entry to the queue
  Future<String> addQueueEntry(QueueEntry entry) async {
    final docRef = await FirebaseFirestore.instance.collection(_collection).add(entry.toJson());
    return docRef.id;
  }

  // Get a stream of the queue for real-time updates
  Stream<List<QueueEntry>> getQueueStream() {
    return _firestoreService.getCollectionStream(_collection).map((snapshot) {
      return snapshot.docs.map((doc) => QueueEntry.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
    });
  }

  // Update an existing entry
  Future<void> updateQueueEntry(QueueEntry entry) async {
    await _firestoreService.updateDocument(_collection, entry.id, entry.toJson());
  }

  // Delete an entry
  Future<void> deleteQueueEntry(String id) async {
    await FirebaseFirestore.instance.collection(_collection).doc(id).delete();
  }

  // Get all entries once (offline compatible if caught in cache)
  Future<List<QueueEntry>> getAll() async {
    final snapshot = await FirebaseFirestore.instance.collection(_collection).get();
    return snapshot.docs.map((doc) => QueueEntry.fromSnapshot(doc)).toList();
  }
}
