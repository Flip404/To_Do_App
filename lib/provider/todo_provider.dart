import 'package:firebase_remote_config/firebase_remote_config.dart';
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

  void toggleTodo(String id, bool? isDone) =>
      ToDoListFeatures.todoCheckBoxUpdate(id: id, isDone: isDone);

  void updateTodo(ToDo todo) => ToDoListFeatures.todoUpdate(todo: todo);

  Stream<List<ToDo>> listTodoDone(String userId) =>
      ToDoListFeatures.todoListDone(userid: userId);

  Stream<List<ToDo>> listTodoNotDone(String userId) =>
      ToDoListFeatures.todoListNotDone(userid: userId);

  bool logSign = true;

  void togglLogIn() {
    logSign = !logSign;
    notifyListeners();
  }

  void connectRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(milliseconds: 1),
        minimumFetchInterval: const Duration(seconds: 1),
      ),
    );
    await remoteConfig.fetchAndActivate();
    final appversion = remoteConfig.getString("app_version");
    debugPrint("appversion : $appversion");
  }
}
