import 'package:bookit/screens/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod

class BookingScreen extends ConsumerWidget {
  final Map<String, dynamic> movie;
  const BookingScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultFontSize = 16.0;
    final titleFontSize = 20.0;
    // State variables can be managed using providers

    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);
    final sortedShowtimes = movie["showtime"];

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
            Text(
              'Select a date:',
              style: TextStyle(fontSize: titleFontSize),
            ),
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
                              style: TextStyle(
                                  fontSize: defaultFontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              [
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat',
                                'Sun',
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
            Text(
              'Select a time:',
              style: TextStyle(fontSize: titleFontSize),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movie["showtime"].length,
                itemBuilder: (context, index) {
                  final showtime = sortedShowtimes[index];
                  return GestureDetector(
                    onTap: () {
                      if (selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a date first.'),
                          ),
                        );
                        return;
                      }
                      ref.read(selectedTimeProvider.notifier).state = showtime;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeatSelection(movie)));
                    },
                    child: SizedBox(
                      width: 100,
                      child: Card(
                        color: selectedTime == showtime
                            ? Colors.orange
                            : Colors.white,
                        child: Center(
                          child: Text(
                            showtime,
                            style: TextStyle(
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Providers for managing state
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);
final selectedTimeProvider = StateProvider<String?>((ref) => null);
