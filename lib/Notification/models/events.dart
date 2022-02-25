class Events {
  late final String id;
  late final DateTime date;
  late final String title;
  Events({required this.id, required this.date, required this.title});
  String toString() => this.title;
}
