import 'package:flutter/material.dart';


class AddTaskScreen extends StatelessWidget {
  final Function(String taskValue) onAddTaskClicked;

  AddTaskScreen({super.key, required this.onAddTaskClicked});

  final textController = TextEditingController();

  void _buttonAddClick(context){
    Navigator.pop(context);
    onAddTaskClicked(textController.text);
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
						TextField(controller: textController, textAlign: TextAlign.center, autofocus: true,),
						TextButton(onPressed: ()=>_buttonAddClick(context),
							child: const Text("ADD"),)
            ],
          ),
        ),
      ),
    );
  }
}
