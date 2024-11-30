import 'package:bookit/providers/seat_provider.dart';
import 'package:bookit/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'export.dart';

final paymentProvider = StateProvider((ref) => "");
final isLoadingProvider = StateProvider((ref) => false);

class PaymentScreen extends ConsumerWidget {
  final Map<String, dynamic> movie;
  PaymentScreen(this.movie, {super.key});
  final List<String> paymentType = [
    'UPI',
    'Wallet',
    'Credit Card',
    'Debit Card',
    'Net Banking'
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.read(selectedDateProvider);
    final selectedTime = ref.read(selectedTimeProvider);
    final seatState = ref.read(seatSelectionProvider);
    final selectedPayment = ref.watch(paymentProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${movie['title']}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Date: ${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Time: $selectedTime',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Selected Seats: ${seatState.selectedSeats.join(', ')}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Select a payment type:',
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: paymentType.length,
                    itemBuilder: (context, index) {
                      final payment = paymentType[index];
                      return ListTile(
                        title: Text(payment),
                        trailing: Radio(
                          value: payment,
                          groupValue: selectedPayment,
                          onChanged: (value) {
                            ref
                                .read(paymentProvider.notifier)
                                .update((_) => value!);
                          },
                        ),
                      );
                    }),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (selectedPayment.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please select a payment method")));
                  } else {
                    ref.read(paymentProvider.notifier).update((state) => "");
                    ref
                        .read(isLoadingProvider.notifier)
                        .update((state) => true);
                    Future.delayed(const Duration(seconds: 3), () {
                      ref
                          .read(isLoadingProvider.notifier)
                          .update((state) => false);
                      if (context.mounted) {
                        Navigator.pushNamed(context, AppRoutes.home);
                      }
                    });
                  }
                },
                child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(color: Colors.orange, boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(2, 2),
                      ),
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Toatal amount: ₹${seatState.selectedSeats.length * 180}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "Click to proceed",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
