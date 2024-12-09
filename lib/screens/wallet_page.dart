import 'package:bookit/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletBalance = ref.watch(walletProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    child: const Text('Top Up Balance'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context) {
    String? selectedPaymentOption;
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 25),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              RadioListTile(
                title: const Text('UPI'),
                value: 'upi',
                groupValue: selectedPaymentOption,
                onChanged: (value) {
                  selectedPaymentOption = value;
                },
              ),
              RadioListTile(
                title: const Text('Debit Card'),
                value: 'debit',
                groupValue: selectedPaymentOption,
                onChanged: (value) {
                  selectedPaymentOption = value;
                },
              ),
              RadioListTile(
                title: const Text('Credit Card'),
                value: 'credit',
                groupValue: selectedPaymentOption,
                onChanged: (value) {
                  selectedPaymentOption = value;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedPaymentOption != null) {
                    // Handle selected payment option
                    Navigator.pop(context); // Close the bottom sheet
                  } else {
                    // Display an error message or handle the case where no option is selected
      
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
