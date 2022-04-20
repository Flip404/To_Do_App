import 'package:first_firebase_project/models/todolist_model.dart';
import 'package:first_firebase_project/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditToDo extends StatefulWidget {
  final ToDo todo;

  const EditToDo(
      {Key? key,
      required this.todo})
      : super(key: key);

  @override
  State<EditToDo> createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo> {
  late String title = '';
  late String description = '';
  final _forvalidateTitle = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final featuresProvider = Provider.of<FeaturesProvider>(context);

    return Form(
      key: _forvalidateTitle,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Text(
                "Edited To Do",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PlayfairDisplay",
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: widget.todo.title,
                onChanged: (e) {
                  setState(() {
                    title = e;
                  });
                },
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
                initialValue: widget.todo.description,
                onChanged: (e) {
                  setState(() {
                    description = e;
                  });
                },
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
                        primary: const Color.fromRGBO(105, 190, 224, 1)),
                    onPressed: (() {
                      if (_forvalidateTitle.currentState!.validate()) {
                        ToDo todo = widget.todo;
                        if (title.isEmpty || description.isEmpty) {
                          if (title.isEmpty && description.isEmpty){
                            todo = widget.todo;
                          } else if (title.isEmpty) {
                            widget.todo.description = description;
                          } else {
                            widget.todo.title = title;
                          }
                        }
                        featuresProvider.updateTodo(todo);
                        Navigator.of(context).pop();
                      }
                    }),
                    child: const Icon(Icons.edit, size: 30)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
