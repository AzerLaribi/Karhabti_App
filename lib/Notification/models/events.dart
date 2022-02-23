class Event {
  late final DateTime date;
  late final String title;
  Event({required this.date, required this.title});
  String toString() => this.title;
}
