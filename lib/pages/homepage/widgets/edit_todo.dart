import 'package:first_firebase_project/features/todolist_features.dart';
import 'package:first_firebase_project/models/todolist_model.dart';
import 'package:flutter/material.dart';

class EditToDo extends StatefulWidget {
  final String widgetId;
  final String widgetTitle;
  final String widgetDescription;

  const EditToDo(
      {Key? key,
      required this.widgetId,
      required this.widgetTitle,
      required this.widgetDescription})
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
                initialValue: widget.widgetTitle,
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
              ),
              const SizedBox(height: 5),
              TextFormField(
                initialValue: widget.widgetDescription,
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
                      if (title.isEmpty || description.isEmpty){
                        if (title.isEmpty){
                          title = widget.widgetTitle;
                        } else{
                          description = widget.widgetDescription;
                        }
                      }
                      ToDoListFeatures.todoUpdate(
                          id: widget.widgetId,
                          title: title,
                          description: description);
                      Navigator.of(context).pop();
                    }
                  }),
                  child: const Icon(Icons.edit, size: 30)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
