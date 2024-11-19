import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show debugPrint;

class DataUploader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadJsonToFirestore(
      String assetPath, String collectionName) async {
    try {
      // Read JSON file from assets
      final String jsonString = await rootBundle.loadString(assetPath);
      final List<dynamic> jsonData = json.decode(jsonString);

      // Create a batch for multiple writes
      final WriteBatch batch = _firestore.batch();

      // Process each item in the JSON array
      for (var item in jsonData) {
        DocumentReference docRef =
            _firestore.collection(collectionName).doc(item['title']);
        batch.set(docRef, item);
      }

      // Commit the batch
      await batch.commit();
      debugPrint(
          'Successfully uploaded data from $assetPath to $collectionName');
    } catch (e) {
      debugPrint('Error uploading data: $e');
      rethrow;
    }
  }

  Future<void> uploadSingleJsonToFirestore(
      String assetPath, String collectionName) async {
    try {
      // Read JSON file from assets
      final String jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Upload the single document
      await _firestore.collection(collectionName).add(jsonData);
      debugPrint(
          'Successfully uploaded data from $assetPath to $collectionName');
    } catch (e) {
      debugPrint('Error uploading data: $e');
      rethrow;
    }
  }

  // Helper method to upload all data
  Future<void> uploadAllData() async {
    try {
      // Upload movies data
      // await uploadJsonToFirestore('assets/nowplaying.json', 'nowplaying');
      await uploadJsonToFirestore('assets/upcoming.json', 'upcoming');
      // Add more data uploads here as needed
      // await uploadJsonToFirestore('assets/data/theaters.json', 'theaters');
      // await uploadJsonToFirestore('assets/data/shows.json', 'shows');
    } catch (e) {
      debugPrint('Error uploading all data: $e');
      rethrow;
    }
  }
}
