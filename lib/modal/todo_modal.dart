class Todo {
  int id;
  String title;
  bool completed;
  DateTime dateTime;
  int dateTimeInEpoch;
  Todo({
    this.id = 0,
    required this.title,
    required this.completed,
    required this.dateTime,
    this.dateTimeInEpoch = 0,
  }) {
    dateTimeInEpoch = dateTime.millisecondsSinceEpoch;
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
      dateTime: json['dateTimeIsCurrentlyNull'] ??
          DateTime.now() //todo Here is the problem
      ,
      dateTimeInEpoch: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'completed': completed,
        'dateTime': (dateTime.millisecondsSinceEpoch).toString(),
      };
}
