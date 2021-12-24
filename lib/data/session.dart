class Session {
  int id = 0;
  int duration = 0;
  String date = '';
  String description = '';

  Session(this.id, this.duration, this.date, this.description);

  Session.fromJson(Map<String, dynamic> sessionMap) {
    id = sessionMap['id'] ?? 0;
    duration = sessionMap['duration'] ?? 0;
    date = sessionMap['date'] ?? '';
    description = sessionMap['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'duration': duration,
      'date': date,
      'description': description
    };
  }
}
