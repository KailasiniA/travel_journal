class Trip {
  final String title;
  final String description;
  final String imagePath;
  final DateTime date; // Date property

  Trip({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date, // Constructor includes date
  });
}
