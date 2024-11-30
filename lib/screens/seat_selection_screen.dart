import 'package:bookit/providers/seat_provider.dart';
import 'package:bookit/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'export.dart';

class SeatSelection extends ConsumerWidget {
  final Map<String, dynamic> movie;
  SeatSelection(this.movie, {super.key});

  final List<List<String>> _seatLayout = [
    ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8'],
    ['B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8'],
    ['C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8'],
    ['D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8'],
    ['E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8'],
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);
    final seatState = ref.watch(seatSelectionProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        title: Text(movie['title']),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.blue[50],
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        DateFormat('EEEE').format(selectedDate!),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "${selectedDate.day.toString()} ${DateFormat('MMM').format(selectedDate)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Card(
                        color: Colors.green.shade300,
                        child: Center(
                          child: Text(
                            selectedTime.toString(),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 50,
              width: 300,
              color: Colors.grey[300],
              child:
                  Center(child: Text('Screen', style: TextStyle(fontSize: 18))),
            ),
            Text('Price: ₹180'),
            // Seat Layout
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _seatLayout.length * _seatLayout[0].length,
                  itemBuilder: (context, index) {
                    int row = index ~/ 8;
                    int col = index % 8;
                    String seatNumber = _seatLayout[row][col];

                    Color seatColor;
                    if (seatState.bookedSeats.contains(seatNumber)) {
                      seatColor = Colors.grey; // Booked seats
                    } else if (seatState.selectedSeats.contains(seatNumber)) {
                      seatColor = Colors.green; // Selected seats
                    } else {
                      seatColor = Colors.blue; // Available seats
                    }

                    return GestureDetector(
                      onTap: seatState.bookedSeats.contains(seatNumber)
                          ? null
                          : () => ref
                              .read(seatSelectionProvider.notifier)
                              .toggleSeat(seatNumber),
                      child: Container(
                        decoration: BoxDecoration(
                          color: seatColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            seatNumber,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Selected Seats and Continue Button
            seatState.selectedSeats.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Selected Seats: ${seatState.selectedSeats.join(", ")}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Total Price: ${seatState.selectedSeats.length} x 180 = ₹${seatState.selectedSeats.length * 180}',
                                style: TextStyle(fontSize: 16)),
                            ElevatedButton(
                              onPressed: seatState.selectedSeats.isNotEmpty
                                  ? () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentScreen(movie)));
                                    }
                                  : null,
                              child: Text('Continue'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
