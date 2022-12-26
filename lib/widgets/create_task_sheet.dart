import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twodo/models/task.dart';
import 'package:twodo/models/todo.dart';
import 'package:twodo/pages/todo_page.dart';
import 'package:twodo/services/todos_service.dart';

class CreateTaskSheet extends StatefulWidget {
  final String todoId;

  CreateTaskSheet(this.todoId);

  @override
  State<StatefulWidget> createState() => _CreateTaskSheet();
}

class _CreateTaskSheet extends State<CreateTaskSheet> {
  Task task = Task.empty();
  static const List<String> sampleTasks = [
    "Buy milk and 8 eggs",
    "Pick up the parcel",
    "Fill the gas tank before our weekend trip",
  ];

  var hint = sampleTasks[Random().nextInt(sampleTasks.length)];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 20, 28, 0),
            child: Text(
              "New task",
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 10, 28, 0),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: hint,
                suffixIcon: const Icon(Icons.text_fields),
              ),
              onChanged: (value) {
                setState(() {
                  task.title = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 10, 28, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Create the todo
                    debugPrint(task.toJson().toString());
                    await TodosService().addTask(widget.todoId, task);

                    // close the sheet.
                    if (!mounted) {
                      return;
                    }
                    Navigator.pop(context, true);
                  },
                  child: const Text("Create"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
