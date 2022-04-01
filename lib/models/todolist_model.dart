import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;

  ToDo({
    this.id = '',
    required this.title,
    this.description = '',
    required this.date,
    this.isDone = false,
  });

  static ToDo fromJson(Map<String, dynamic> json) => ToDo(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        date: (json['date'] as Timestamp).toDate(),
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date,
        'isDone': isDone,
      };
}
