import 'dart:developer';

import 'package:bookit/providers/booking_provider.dart';
import 'package:bookit/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod

class BookingScreen extends ConsumerWidget {
  final Map<String, dynamic> movie;
  const BookingScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State variables can be managed using providers
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);
    final selectedSeats = ref.watch(selectedSeatsProvider);
    ref.read(profileProvider);
    final isLoading =
        ref.watch(isLoadingProvider); // Use a provider for isLoading

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking - ${movie['title']}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Select a date:'),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final date = DateTime.now().add(Duration(days: index));
                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedDateProvider.notifier).state = date;
                      log('$date');
                    },
                    child: Card(
                      color: selectedDate?.day == date.day
                          ? Colors.orange
                          : Colors.white,
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${date.day}',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              [
                                'Sun',
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat'
                              ][date.weekday - 1],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Select a time:'),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movie["showtime"].length,
                itemBuilder: (context, index) {
                  final sortedShowtimes = List<String>.from(movie["showtime"])
                    ..sort((a, b) {
                      final aFormatted = a.padLeft(5, '0');
                      final bFormatted = b.padLeft(5, '0');
                      return DateTime.parse("1970-01-01 $aFormatted")
                          .compareTo(DateTime.parse("1970-01-01 $bFormatted"));
                    });
                  final showtime = sortedShowtimes[index];
                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedTimeProvider.notifier).state = showtime;
                    },
                    child: Card(
                      color: selectedTime == showtime
                          ? Colors.orange
                          : Colors.white,
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              showtime,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Select number of seats:'),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  final seatCount = index + 1;
                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedSeatsProvider.notifier).state =
                          seatCount;
                      log('Selected $seatCount seat(s)');
                    },
                    child: Card(
                      color: selectedSeats == seatCount
                          ? Colors.orange
                          : Colors.white,
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$seatCount',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        ref.read(isLoadingProvider.notifier).state =
                            true; // Set isLoading to true
                        // Prepare booking details
                        final bookingDetails = {
                          'movie': movie['title'],
                          'date':
                              selectedDate?.toLocal().toString().split(' ')[0],
                          'time': selectedTime,
                          'seats': selectedSeats,
                        };

                        // Call the booking provider
                        final result = await ref
                            .read(bookingProvider(bookingDetails).future);

                        // Handle the result
                        ref.read(isLoadingProvider.notifier).state =
                            false; // Set isLoading to false
                        if (result.success) {
                          if (!context.mounted) {
                            return; // Check if the widget is still mounted
                          }
                          Navigator.pop(context); // Go back to the home page
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking successful!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Show success message or navigate
                        } else {
                          log('Error: ${result.message}');
                          // Show error message
                        }
                      },
                child: isLoading
                    ? const CircularProgressIndicator() // Show loading indicator
                    : const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Providers for managing state
final selectedDateProvider = StateProvider.autoDispose<DateTime?>((ref) => null);
final selectedTimeProvider = StateProvider.autoDispose<String?>((ref) => null);
final selectedSeatsProvider = StateProvider.autoDispose<int>((ref) => 1);
final isLoadingProvider =
    StateProvider.autoDispose<bool>((ref) => false); // Add isLoading provider
