import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/models/todolist_model.dart';
import 'package:first_firebase_project/pages/homepage/widgets/add_todo.dart';
import 'package:first_firebase_project/pages/homepage/widgets/edit_todo.dart';
import 'package:first_firebase_project/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_firebase_project/provider/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final featuresProvider = Provider.of<FeaturesProvider>(context);
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(164, 210, 224, 1),
          title: const Text("To Do List",
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontFamily: "PlayfairDisplay", color: Color.fromRGBO(56, 52, 40, 1))),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(featuresProvider.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode),
              onPressed: () {
                final theme =
                    Provider.of<FeaturesProvider>(context, listen: false);
                featuresProvider.isDarkMode
                    ? theme.toggleTheme(false)
                    : theme.toggleTheme(true);
              }),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => FirebaseAuth.instance.signOut()
            )
          ],
        ),
        body: StreamBuilder<List<ToDo>>(
            stream: featuresProvider.listTodo(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text("Something was wrong ${snapshot.error}"));
              } else if (snapshot.hasData) {
                final data = snapshot.data!;
                if (data.isEmpty) {
                  return const Center(
                      child: Text(
                    "No Lists.",
                    style: TextStyle(
                        fontFamily: "PlayfairDisplay",
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ));
                } else {
                  return ListView(
                    children: data.map(buildToDo).toList(),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(164, 210, 224, 1),
          child: const Icon(
            Icons.add,
            size: 35,
            color: Color.fromRGBO(56, 52, 40, 1),
          ),
          onPressed: () => showDialog(
              context: context, builder: (context) => const AddToDo()),
        ));
  }

  Widget buildToDo(ToDo todo){
    
    final featuresProvider = Provider.of<FeaturesProvider>(context);
    
    return Card(
        color: const Color.fromRGBO(164, 210, 224, 1),
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
            textColor: const Color.fromRGBO(56, 52, 40, 1),
            leading: Checkbox(
              activeColor: const Color.fromRGBO(103, 195, 146, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              value: todo.isDone,
              onChanged: ((value) {
                featuresProvider.toggleTodo(todo.id, value);
              }),
            ),
            title: Text(
              todo.title.toUpperCase(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              todo.description,
              style: const TextStyle(fontSize: 15),
            ),
            trailing: IconButton(
                onPressed: (() {
                  Utils.showSnackBar('Deleted!');
                  featuresProvider.removeTodo(todo.id);
                }),
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromRGBO(10, 12, 28, 1),
                )),
            onTap: () => showDialog(
                context: context,
                builder: (context) => EditToDo(todo: todo))
        ),
      );
  }
}
