import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(String taskValue) onAddTaskClicked;

  const AddTaskScreen({super.key, required this.onAddTaskClicked});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final textController = TextEditingController();
  void _buttonAddClick(context) {
    Navigator.pop(context);
    widget.onAddTaskClicked(textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "Add your task here ..",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              TextField(
                controller: textController,
                textAlign: TextAlign.center,
                autofocus: true,
              ),
              TextButton(
                onPressed: () => _buttonAddClick(context),
                child: const Text("ADD"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
