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

const List<String> _temporaryEmails = ["foo", "foo@example.com"];
String getPartnerName(List<String> owners) {
  String _partner = owners[0];
  if (_partner == FirebaseAuth.instance.currentUser?.email) {
    _partner = owners[1];
  } else if (_temporaryEmails.contains(_partner)) {
    _partner = owners[1];
  }

  return _partner;
}

class _TodoListState extends State<TodoList> {
  Future<List<Todo>?>? getTodos;

  @override
  void initState() {
    getTodos = TodosService().getTodos();
    super.initState();
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
                if (data[index].tasks.isEmpty) {
                  tasksString = "No tasks created yet.";
                }
                return Dismissible(
                  key: Key(data[index].id),
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: ListTile(
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
                    subtitle: Wrap(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8.0),
                                ),
                              ),
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.group,
                                      color: Colors.purple,
                                    ),
                                    title: Text(
                                      getPartnerName(
                                        data[index]
                                            .owners
                                            .map((e) => e as String)
                                            .toList(),
                                      ),
                                    ),
                                    // add trailing for the collections with this collaborator.
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            getPartnerName(
                              data[index]
                                  .owners
                                  .map((owner) => owner as String)
                                  .toList(),
                            ),
                            style: TextStyle(
                              color: Colors.grey[800],
                              decorationStyle: TextDecorationStyle.dashed,
                            ),
                          ),
                        ),
                        const Text(" · "),
                        Text(tasksString),
                      ],
                    ),
                    isThreeLine: true,
                    // tileColor: Colors[data[index].colorAccent],
                    trailing: IconButton(
                      icon: Icon(
                        Icons.star,
                        color:
                            data[index].favorite ? Colors.orange : Colors.grey,
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
                  ),
                  onDismissed: (direction) {
                    // delete the todo
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
