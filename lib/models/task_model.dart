class Task {
  final String id;
  final String title;
  final String description;
  final dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: json['dueDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
    };
  }
}
