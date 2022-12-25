import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twodo/models/todo.dart';
import 'package:twodo/pages/todo_page.dart';
import 'package:twodo/services/todos_service.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const String _temporaryEmail = "foo";
  Future<List<Todo>?>? getTodos;

  @override
  void initState() {
    getTodos = TodosService().getTodos();
    super.initState();
  }

  String getPartnerName(List<String> owners) {
    String _partner = owners[0];
    if (_partner == FirebaseAuth.instance.currentUser?.email) {
      _partner = owners[1];
    } else if (_partner == _temporaryEmail) {
      _partner = owners[1];
    }

    return _partner;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTodos,
      builder: (BuildContext context, AsyncSnapshot<List<Todo>?> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && snapshot.data == null) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          List<Todo> data = snapshot.data!;
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                var tasksDone = data[index].tasks.where((t) => t.done).length;
                var tasksString =
                    "${data[index].tasks.where((t) => t.done).length}/${data[index].tasks.length} tasks";

                if (tasksDone == 0) {
                  tasksString = "Getting started 💪";
                }
                if (tasksDone == data[index].tasks.length) {
                  tasksString = "All caught up! 🎉";
                }
                return ListTile(
                  leading: IconButton(
                    tooltip: "Delete when the tasks are marked as done.",
                    icon: Icon(
                      Icons.auto_delete,
                      color: data[index].deleteWhenDone
                          ? Colors.purple
                          : Colors.grey,
                    ),
                    onPressed: () {
                      var todo = data[index];
                      todo.deleteWhenDone = !data[index].deleteWhenDone;
                      TodosService().updateTodo(data[index].id, todo);
                      setState(() {});
                    },
                  ),
                  title: Text(
                    data[index].title,
                  ),
                  subtitle: Text(
                    "${getPartnerName(
                      data[index]
                          .owners
                          .map((owner) => owner as String)
                          .toList(),
                    )} • $tasksString",
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.star,
                      color: data[index].favorite ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () {
                      // update the todo
                      var todo = data[index];
                      todo.favorite = !data[index].favorite;
                      TodosService().updateTodo(data[index].id, todo);
                      setState(() {});
                    },
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            TodoPage(data[index].id),
                      ),
                    );
                    setState(() {
                      getTodos = TodosService().getTodos();
                    });
                    debugPrint("${data[index].id} was pressed");
                  },
                );
              },
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
