class SummaryItem {
  final String title;
  final String value;

  const SummaryItem({required this.title, required this.value});
}

class ActionItem {
  final String title;
  final String subtitle;

  const ActionItem({required this.title, required this.subtitle});
}

class ClassItem {
  final String title;
  final String time;
  final String location;

  const ClassItem({
    required this.title,
    required this.time,
    required this.location,
  });
}
