class EventModel {
  final String title;
  final String description;
  final String location;

  EventModel({
    required this.title,
    required this.description,
    required this.location,
  });

  String get searchableText =>
      '$title $description $location'.toLowerCase();
}
