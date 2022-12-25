import 'package:firebase_auth/firebase_auth.dart';
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
      height: 360,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 20, 28, 0),
            child: Text(
              "New todo",
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 10, 28, 0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title for the list',
              ),
              onChanged: (value) {
                setState(() {
                  todo.title = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 10, 28, 0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'collaborator@example.com',
              ),
              onChanged: (value) {
                setState(() {
                  var me = FirebaseAuth.instance.currentUser?.email;
                  todo.owners = [me, value];
                });
              },
            ),
          ),
          ListTile(
            leading: Checkbox(
              value: todo.deleteWhenDone,
              onChanged: (value) {},
            ),
            title: const Text("Delete when the tasks are done"),
            onTap: () {
              setState(() {
                todo.deleteWhenDone = !todo.deleteWhenDone;
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: Text(
              "Add the tasks on the next page after creating the todo.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 10, 28, 0),
            child: Row(
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
          ),
        ],
      ),
    );
  }
}
