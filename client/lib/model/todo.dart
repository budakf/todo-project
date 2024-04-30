import 'dart:convert';

class Todo{
  int? id;
  String message;
  bool important;
  bool done;

  Todo({
    required this.message,
    required this.important,
    required this.done,
  });

  Todo.withId({
    required this.id,
    required this.message,
    required this.important,
    required this.done,
  });

  @override
  String toString() {
    return '{id:$id, message:$message, important:$important, done:$done}';
  }

  static Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));
  static List<Todo> todoListFromJson(String str) => List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

  static String todoToJson(Todo data) => json.encode(data.toJson());
  static String todoListToJson(List<Todo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  Map<String, dynamic> toJson() => {
    "message": message,
    "important": important,
    "done": done,
  };

  factory Todo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'message': String message,
        'important': bool important,
        'done': bool done,
      } =>
        Todo.withId(
          id: id,
          message: message,
          important: important,
          done: done,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }

}