import '../core/db/database_helper.dart';

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

  factory QueueEntry.fromJson(Map<String, dynamic> json) => QueueEntry(
    id: json['id'] as String,
    patientId: json['patient_id'] as String,
    token: json['token'] as String,
    doctorId: json['doctor_id'] as String,
    status: json['status'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'patient_id': patientId,
    'token': token,
    'doctor_id': doctorId,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class QueueRepository {
  final db = DatabaseHelper.instance.database;

  Future<String> insert(QueueEntry entry) async {
    final database = await db;
    await database.insert('queue', entry.toJson());
    return entry.id;
  }

  Future<List<QueueEntry>> getAll() async {
    final database = await db;
    final result = await database.query('queue', orderBy: 'created_at ASC');
    return result.map((json) => QueueEntry.fromJson(json)).toList();
  }

  Future<int> update(QueueEntry entry) async {
    final database = await db;
    return database.update(
      'queue',
      entry.toJson(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> delete(String id) async {
    final database = await db;
    return database.delete('queue', where: 'id = ?', whereArgs: [id]);
  }
}
