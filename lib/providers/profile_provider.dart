import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileState {
  final String? username;
  final String? email;
  final String? profileImageUrl;
  final bool isLoading;
  final String? error;

  ProfileState({
    this.username,
    this.email,
    this.profileImageUrl,
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    String? username,
    String? email,
    String? profileImageUrl,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      username: username ?? this.username,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(ProfileState()) {
    _loadProfile(); // Load initial profile data
  }

  Future<void> _loadProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists) {
        state = ProfileState(
          username: doc.data()?['username'],
          email: doc.data()?['email'],
          profileImageUrl: doc.data()?['profileImageUrl'],
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateProfile({
    required String username,
    required String email,
    File? imageFile,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      String? imageUrl = state.profileImageUrl;

      if (imageFile != null) {
        try {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('profile_images')
              .child('$uid.jpg');

          await storageRef.putFile(imageFile);
          imageUrl = await storageRef.getDownloadURL();
        } catch (e) {
          throw 'Failed to upload image: $e';
        }
      }

      try {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': username,
          'email': email,
          if (imageUrl != null) 'profileImageUrl': imageUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } catch (e) {
        throw 'Failed to update profile: $e';
      }

      state = ProfileState(
        username: username,
        email: email,
        profileImageUrl: imageUrl,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }
}

// Create the provider
final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});
