import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/models/todolist_model.dart';
import 'package:first_firebase_project/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({Key? key}) : super(key: key);

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  final _forvalidateTitle = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final featuresProvider = Provider.of<FeaturesProvider>(context);
    final user = FirebaseAuth.instance.currentUser!;

    return Form(
      key: _forvalidateTitle,
      child: AlertDialog(
        shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.circular(20.0),  
        ),
        title: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Create To Do",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PlayfairDisplay",
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: title,
                maxLines: 1,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.title,
                    color: Color.fromRGBO(105, 190, 224, 1),
                  ),
                  labelText: "Title",
                  labelStyle: TextStyle(
                      color: Color.fromRGBO(105, 190, 224, 1),
                      fontFamily: "PlayfairDisplay",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  floatingLabelStyle: TextStyle(
                      color: Color.fromRGBO(105, 190, 224, 0.8),
                      fontFamily: "PlayfairDisplay",
                      fontSize: 18,
                      letterSpacing: 2),
                ),
                validator: (t) {
                  if (t == null || t.isEmpty) {
                    return "Don't Forget to fill the title";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: description,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.list,
                    color: Color.fromRGBO(105, 190, 224, 1),
                  ),
                  labelText: "Description",
                  labelStyle: TextStyle(
                      color: Color.fromRGBO(105, 190, 224, 1),
                      fontFamily: "PlayfairDisplay",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  floatingLabelStyle: TextStyle(
                      color: Color.fromRGBO(105, 190, 224, 0.8),
                      fontFamily: "PlayfairDisplay",
                      fontSize: 18,
                      letterSpacing: 2),
                ),
                maxLines: 2,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(105, 190, 224, 1)
                  ),
                  onPressed: (() {
                    if (_forvalidateTitle.currentState!.validate()) {
                      DateTime date = DateTime.now();
                      ToDo todo = ToDo(
                          title: title.text,
                          description: description.text,
                          date: date,
                          userId: user.uid);
                      featuresProvider.addTodo(todo);
                      Navigator.of(context).pop();
                    }
                  }),
                  child: const Text("Save")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
