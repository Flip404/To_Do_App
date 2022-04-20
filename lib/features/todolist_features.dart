import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_firebase_project/models/todolist_model.dart';
import 'dart:async';

class ToDoListFeatures {
  
  static Future todoAdd({required ToDo todo}) async {
    final tododoc = FirebaseFirestore.instance.collection('ToDoList').doc();
    todo.id = tododoc.id;
    final todojson = todo.toJson();
    await tododoc.set(todojson);
  }

  static Stream<List<ToDo>> todoList({required String userid}) => FirebaseFirestore.instance
      .collection('ToDoList')
      .where('userId', isEqualTo: userid)
      .snapshots()
      .map((event) => event.docs.map((e) => ToDo.fromJson(e.data())).toList());

  static Future todoUpdate(
      {required ToDo todo}) async {
    final tododoc = FirebaseFirestore.instance.collection('ToDoList').doc(todo.id);
    tododoc.update(todo.toJson());
  }

  static Future todoCheckBoxUpdate({required String id, required bool? isDone}) async {
    final tododoc = FirebaseFirestore.instance.collection('ToDoList').doc(id);
    tododoc.update({'isDone': isDone});
  }

  static Future todoDelete({required String id}) async =>
      FirebaseFirestore.instance.collection('ToDoList').doc(id).delete();
}
