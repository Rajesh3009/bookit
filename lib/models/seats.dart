class Seat {
  final int row;
  final int column;
  bool isSelected;
  bool isBooked;

  Seat({
    required this.row,
    required this.column,
    this.isSelected = false,
    this.isBooked = false,
  });
}
