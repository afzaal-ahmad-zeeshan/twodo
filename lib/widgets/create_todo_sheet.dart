import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twodo/models/todo.dart';
import 'package:twodo/pages/todo_page.dart';
import 'package:twodo/services/todos_service.dart';

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
                labelText: 'Title for the list',
                suffixIcon: Icon(Icons.text_fields),
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
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'collaborator@example.com',
                    suffixIcon: Icon(
                      Icons.group,
                    ),
                    helperText: "You cannot change the collaborator later.",
                  ),
                  onChanged: (value) {
                    setState(() {
                      var me = FirebaseAuth.instance.currentUser?.email;
                      todo.owners = [me ?? "foo@example.com", value];
                    });
                  },
                ),
              ],
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
                  onPressed: () async {
                    // Create the todo
                    debugPrint(todo.toJson().toString());
                    await TodosService().addTodo(todo);

                    // close the sheet.
                    if (!mounted) {
                      return;
                    }
                    Navigator.pop(context);

                    // open the todo page
                    await Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => TodoPage(todo.id),
                      ),
                    );
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
