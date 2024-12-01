import 'package:bookit/models/seats.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final seatSelectionProvider =
    NotifierProvider.autoDispose<SeatSelectionNotifier, SeatSelection>(() {
  return SeatSelectionNotifier();
});

class SeatSelectionNotifier extends AutoDisposeNotifier<SeatSelection> {
  @override
  SeatSelection build() {
    // Use ref.onDispose to reset state when provider is disposed
    ref.onDispose(() {
      // Reset to initial state when page is left
      state = SeatSelection();
    });

    return SeatSelection();
  }

  void toggleSeat(String seatNumber) {
    final currentState = state;

    // Prevent selecting booked seats
    if (currentState.bookedSeats.contains(seatNumber)) return;

    final updatedSelectedSeats = Set<String>.from(currentState.selectedSeats);

    if (updatedSelectedSeats.contains(seatNumber)) {
      updatedSelectedSeats.remove(seatNumber);
    } else {
      updatedSelectedSeats.add(seatNumber);
    }

    state = currentState.copyWith(selectedSeats: updatedSelectedSeats);
  }

  void clearSelectedSeats() {
    state = state.copyWith(selectedSeats: {});
  }
}
