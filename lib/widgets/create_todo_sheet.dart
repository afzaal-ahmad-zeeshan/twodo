import 'package:flutter/material.dart';
import 'package:twodo/models/todo.dart';

class CreateTodoSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateTodoSheet();
}

class _CreateTodoSheet extends State<CreateTodoSheet> {
  Todo todo = Todo.empty();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              "New todo",
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    debugPrint(todo.toString());
                  },
                  child: const Text("Create"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
