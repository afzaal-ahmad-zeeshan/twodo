import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twodo/models/todo.dart';
import 'package:twodo/pages/todo_page.dart';
import 'package:twodo/services/todos_service.dart';

class CollaboratorSheet extends StatefulWidget {
  final String collaborator;
  final String todoId;

  CollaboratorSheet(
    this.collaborator,
    this.todoId,
  );

  @override
  State<StatefulWidget> createState() => _CollaboratorSheet();
}

class _CollaboratorSheet extends State<CollaboratorSheet> {
  Todo? todo;

  @override
  void initState() {
    // load the todo
    TodosService().findTodo(widget.todoId).then((t) => {
          todo = t,
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 20, 28, 0),
            child: Text(
              "Update the collaborator",
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
                    helperText:
                        "You can change the collaborator later as well.",
                  ),
                  onChanged: (value) {
                    setState(() {
                      var me = FirebaseAuth.instance.currentUser?.email;
                      todo!.owners = [me ?? "foo@example.com", value];
                    });
                  },
                ),
              ],
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
                    // Update the todo
                    debugPrint(todo!.toJson().toString());
                    await TodosService().addTodo(todo!);

                    // refresh
                    if (!mounted) {
                      return;
                    }
                    setState(() {});
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
