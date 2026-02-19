
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment_model.dart';
import '../../auth/models/user_model.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection References
  CollectionReference get _appointments =>
      _firestore.collection('appointments');
  CollectionReference get _users => _firestore.collection('users');

  // Book an appointment
  Future<void> bookAppointment(AppointmentModel appointment) async {
    try {
      // Check for double booking (basic check)
      // Check if the doctor already has an appointment at this time
      final querySnapshot = await _appointments
          .where('doctorId', isEqualTo: appointment.doctorId)
          .where('dateTime', isEqualTo: Timestamp.fromDate(appointment.dateTime))
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        throw Exception('This time slot is already booked.');
      }
      
      await _appointments.doc(appointment.id).set(appointment.toMap());
    } catch (e) {
      throw Exception('Failed to book appointment: $e');
    }
  }

  // Get Doctors
  Future<List<UserModel>> getDoctors() async {
    try {
      final querySnapshot = await _users
          .where('role', isEqualTo: 'doctor') // Stored as string in Firestore based on UserModel.toMap
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to load doctors: $e');
    }
  }

  // Get available slots (Mocked logic for now, could be enhanced)
  // Returns a list of available DateTimes for a given day
  Future<List<DateTime>> getAvailableSlots(String doctorId, DateTime date) async {
    // 1. Define working hours (e.g., 9 AM to 5 PM)
    final startHour = 9;
    final endHour = 17;
    final intervalMinutes = 30;

    List<DateTime> allSlots = [];
    for (int hour = startHour; hour < endHour; hour++) {
      allSlots.add(DateTime(date.year, date.month, date.day, hour, 0));
      allSlots.add(DateTime(date.year, date.month, date.day, hour, 30));
    }

    // 2. Fetch existing appointments for that day
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final querySnapshot = await _appointments
        .where('doctorId', isEqualTo: doctorId)
        .where('dateTime', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('dateTime', isLessThan: Timestamp.fromDate(endOfDay))
        .get();

    final bookedSlots = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return (data['dateTime'] as Timestamp).toDate();
    }).toList();

    // 3. Filter out booked slots
    // Using a simplistic equality check. In real apps, range checks are needed.
    return allSlots.where((slot) {
      // Check if any booked slot matches this slot
      return !bookedSlots.any((booked) => booked.isAtSameMomentAs(slot));
    }).toList();
  }
}
