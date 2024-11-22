import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingResult {
  final bool success;
  final String message;

  BookingResult({required this.success, required this.message});
}

final bookingProvider = FutureProvider.autoDispose
    .family<BookingResult, Map<String, dynamic>>((ref, bookingDetails) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    return BookingResult(success: false, message: 'User not logged in');
  }

  try {
    await FirebaseFirestore.instance.collection('bookings').add({
      'userId': uid,
      'movie': bookingDetails['movie'],
      'date': bookingDetails['date'],
      'time': bookingDetails['time'],
      'seats': bookingDetails['seats'],
      'createdAt': FieldValue.serverTimestamp(),
    });
    return BookingResult(success: true, message: 'Booking successful');
  } catch (e) {
    return BookingResult(success: false, message: 'Failed to book: $e');
  }
});
