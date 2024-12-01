
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletNotifier extends StateNotifier<double> {
  WalletNotifier(super.state) {
    state = 100.0;
  }
}
final walletProvider =
    StateNotifierProvider<WalletNotifier, double>((ref) => WalletNotifier(0.0));
