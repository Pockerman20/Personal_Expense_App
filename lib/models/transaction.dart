class Transactions {
  late final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transactions(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
