class Reminder {
  /// Unique notification id
  final int id;

  /// Reminder title (shown in notification)
  final String title;

  /// Optional notes / description
  final String body;

  /// Exact date & time when notification should fire
  final DateTime dateTime;

  const Reminder({
    required this.id,
    required this.title,
    required this.body,
    required this.dateTime,
  });

  /// Convert to Map (useful for DB / JSON later)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  /// Create Reminder from Map
  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }

  /// CopyWith (for edit reminder later)
  Reminder copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? dateTime,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
