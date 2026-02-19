import '../core/db/database_helper.dart';

class DoctorModel {
  final String id;
  final String name;
  final String? specialization;
  final bool isAvailable;

  DoctorModel({
    required this.id,
    required this.name,
    this.specialization,
    required this.isAvailable,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json['id'] as String,
        name: json['name'] as String,
        specialization: json['specialization'] as String?,
        isAvailable: (json['is_available'] as int) == 1,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'specialization': specialization,
        'is_available': isAvailable ? 1 : 0,
      };
}

class DoctorRepository {
  final db = DatabaseHelper.instance.database;

  Future<String> insert(DoctorModel doctor) async {
    final database = await db;
    await database.insert('doctors', doctor.toJson());
    return doctor.id;
  }

  Future<List<DoctorModel>> getAll() async {
    final database = await db;
    final result = await database.query('doctors');
    return result.map((json) => DoctorModel.fromJson(json)).toList();
  }

  Future<int> update(DoctorModel doctor) async {
    final database = await db;
    return database.update(
      'doctors',
      doctor.toJson(),
      where: 'id = ?',
      whereArgs: [doctor.id],
    );
  }

  Future<int> delete(String id) async {
    final database = await db;
    return database.delete('doctors', where: 'id = ?', whereArgs: [id]);
  }
}
