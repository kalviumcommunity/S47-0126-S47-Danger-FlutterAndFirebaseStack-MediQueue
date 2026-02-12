import '../core/db/database_helper.dart';

class PatientModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String createdAt;

  PatientModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.createdAt,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    id: json['id'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String?,
    createdAt: json['created_at'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'created_at': createdAt,
  };
}

class PatientRepository {
  final db = DatabaseHelper.instance.database;

  Future<String> insert(PatientModel patient) async {
    final database = await db;
    await database.insert('patients', patient.toJson());
    return patient.id;
  }

  Future<List<PatientModel>> getAll() async {
    final database = await db;
    final result = await database.query('patients', orderBy: 'created_at ASC');
    return result.map((json) => PatientModel.fromJson(json)).toList();
  }

  Future<int> update(PatientModel patient) async {
    final database = await db;
    return database.update(
      'patients',
      patient.toJson(),
      where: 'id = ?',
      whereArgs: [patient.id],
    );
  }

  Future<int> delete(String id) async {
    final database = await db;
    return database.delete('patients', where: 'id = ?', whereArgs: [id]);
  }
}
