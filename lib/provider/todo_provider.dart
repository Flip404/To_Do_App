import 'package:first_firebase_project/features/todolist_features.dart';
import 'package:first_firebase_project/models/todolist_model.dart';
import 'package:flutter/material.dart';

class FeaturesProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  bool get isDarkMode => mode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    mode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void addTodo(ToDo todo) => ToDoListFeatures.todoAdd(todo: todo);

  void removeTodo(String id) => ToDoListFeatures.todoDelete(id: id);

  void toggleTodo(String id, bool? isDone) => ToDoListFeatures.todoCheckBoxUpdate(id: id, isDone: isDone);

  void updateTodo(ToDo todo) => ToDoListFeatures.todoUpdate(todo: todo);

  Stream<List<ToDo>> listTodo(String userId) => ToDoListFeatures.todoList(userid: userId);
}
