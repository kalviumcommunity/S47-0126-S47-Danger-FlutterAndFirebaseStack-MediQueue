import 'package:sqflite/sqflite.dart';

Future<void> saveToken(Database database, String token, String patientId) async {
  await database.insert('queue', {
    'token': token,
    'patient_id': patientId,
    'created_at': DateTime.now().toIso8601String(),
    'status': 'waiting',
  });
}
