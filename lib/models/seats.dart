class SeatSelection {
  final Set<String> selectedSeats;
  final Set<String> bookedSeats;

  SeatSelection({
    Set<String>? selectedSeats,
    Set<String>? bookedSeats,
  })  : selectedSeats = selectedSeats ?? {},
        bookedSeats = bookedSeats ?? {'B4', 'C5', 'D6'};

  SeatSelection copyWith({
    Set<String>? selectedSeats,
    Set<String>? bookedSeats,
  }) {
    return SeatSelection(
      selectedSeats: selectedSeats ?? this.selectedSeats,
      bookedSeats: bookedSeats ?? this.bookedSeats,
    );
  }
}
