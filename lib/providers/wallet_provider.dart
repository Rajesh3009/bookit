import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletNotifier extends StateNotifier<double> {
  WalletNotifier(super.state) {
    _load();
  }

  _load() async {
    state = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((doc) => state = doc.data()!['wallet']) ??
        0;
  }
}

final walletProvider =
    StateNotifierProvider<WalletNotifier, double>((ref) => WalletNotifier(0.0));
