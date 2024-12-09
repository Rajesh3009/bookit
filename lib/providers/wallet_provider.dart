import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletNotifier extends StateNotifier<double> {
  WalletNotifier(super.state) {
    state = 0.00;
    _load();
  }

  _load() async {
    state = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value['wallet'] ?? 0.00);
  }

  Future<void> updateWallet(double amount) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'wallet': state + amount});
  }
}

final walletProvider =
    StateNotifierProvider.autoDispose<WalletNotifier, double>((ref) => WalletNotifier(0.0));
