import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Api {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getNowPlayingMovies() async {
    try {
      final snapshot = await _firestore
          .collection('movies')
          .where('status', isEqualTo: 'playing')
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      debugPrint('Error loading now playing movies: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getUpcomingMovies() async {
    try {
      final snapshot = await _firestore
          .collection('movies')
          .where('status', isEqualTo: 'upcoming')
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      debugPrint('Error loading upcoming movies: $e');
      return [];
    }
  }
}
