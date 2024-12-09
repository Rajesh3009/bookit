import 'dart:developer';

import 'package:bookit/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPaymentOption = StateProvider.autoDispose((ref) => "");
final isUpdateProvider = StateProvider.autoDispose((ref) => false);

class WalletPage extends ConsumerWidget {
  WalletPage({super.key});
  final walletController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletBalance = ref.watch(walletProvider);
    final isUpdate = ref.watch(isUpdateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Balance: ₹$walletBalance',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.read(isUpdateProvider.notifier).state = true;
                      },
                      child: const Text('Top Up Balance'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(walletProvider);
                      },
                      child: const Text('Refresh Balance'),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                _showBottomSheet(context, ref, isUpdate),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showBottomSheet(BuildContext context, WidgetRef ref, bool isUpdate) {
    final selectedPayment = ref.watch(selectedPaymentOption);
    return isUpdate
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 30),
                TextField(
                  controller: walletController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                RadioListTile<String>(
                  title: const Text('UPI'),
                  value: 'upi',
                  groupValue: selectedPayment,
                  onChanged: (value) {
                    ref.read(selectedPaymentOption.notifier).state = 'upi';
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Debit Card'),
                  value: 'debit',
                  groupValue: selectedPayment,
                  onChanged: (value) {
                    ref.read(selectedPaymentOption.notifier).state = 'debit';
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Credit Card'),
                  value: 'credit',
                  groupValue: selectedPayment,
                  onChanged: (value) {
                    ref.read(selectedPaymentOption.notifier).state = 'credit';
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle selected payment option
                    if (ref.read(selectedPaymentOption).isEmpty) {
                      log('Please select a payment option.');
                      return;
                    }
                    if (walletController.text.isNotEmpty) {
                      ref
                          .read(walletProvider.notifier)
                          .updateWallet(double.parse(walletController.text));

                      ref.invalidate(walletProvider);
                    }
                    ref.read(isUpdateProvider.notifier).state = false;
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
