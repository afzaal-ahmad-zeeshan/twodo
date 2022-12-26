import 'package:flutter/material.dart';
import 'package:twodo/models/todo.dart';
import 'package:twodo/services/todos_service.dart';
import 'package:twodo/widgets/collaborator_sheet.dart';
import 'package:twodo/widgets/create_task_sheet.dart';
import 'package:twodo/widgets/todo_list.dart';

class TodoPage extends StatefulWidget {
  final String todoId;

  TodoPage(this.todoId);

  @override
  State<StatefulWidget> createState() => _TodoPageState();
}

// Improve the DateTime format.
String parseDate(String date) {
  var d = DateTime.tryParse(date);

  if (d == null) {
    return "";
  }

  return "${d.year.toString()}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} ${d.hour.toString().padLeft(2, '0')}-${d.minute.toString().padLeft(2, '0')}";
}

class _TodoPageState extends State<TodoPage> {
  String title = "Loading...";
  Future<Todo?>? findTodo;
  Todo? todo;

  @override
  void initState() {
    findTodo = TodosService().findTodo(widget.todoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          // Show the bottom sheet to update the collaborator.
          IconButton(
            onPressed: () {
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
                    child: CollaboratorSheet(
                        getPartnerName(
                          todo!.owners.map((e) => e as String).toList(),
                        ),
                        widget.todoId),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.group,
            ),
            color: Colors.purple,
            tooltip: "The collaborator for this collection.",
          ),
        ],
      ),
      body: FutureBuilder(
        future: findTodo,
        builder: (BuildContext context, AsyncSnapshot<Todo?> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && snapshot.data == null) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Todo data = snapshot.data!;
            Future.delayed(Duration.zero, () async {
              setState(() {
                title = data.title;
                todo = data;
              });
            });
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.tasks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(data.tasks[index].id),
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
                        leading: Checkbox(
                          value: data.tasks[index].done,
                          onChanged: (value) async {
                            // change the state.
                            var task = data.tasks[index];
                            task.done = value!;
                            await TodosService()
                                .updateTask(widget.todoId, task);
                            setState(() {});
                          },
                        ),
                        title: Text(
                          data.tasks[index].title,
                        ),
                        subtitle: data.tasks[index].doBefore.isEmpty
                            ? null
                            : Text(
                                parseDate(data.tasks[index].doBefore),
                              ),
                        isThreeLine: data.tasks[index].doBefore.isNotEmpty,
                        trailing: IconButton(
                          icon: Icon(
                            Icons.star,
                            color: data.tasks[index].favorite
                                ? Colors.orange
                                : Colors.grey,
                          ),
                          onPressed: () {
                            var _task = data.tasks[index];
                            _task.favorite = !_task.favorite;
                            TodosService().updateTask(widget.todoId, _task);
                          },
                        ),
                        // onTap: () {
                        //   debugPrint("${data.tasks[index].id} was pressed");
                        // },
                      ),
                      onDismissed: (direction) {
                        // remove the element and update todo
                        var title = data.tasks[index].title;
                        data.tasks.removeAt(index);

                        // update Firebase
                        TodosService().updateTodo(widget.todoId, todo!);

                        // show the snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '$title has been deleted.',
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Divider(
                      color: Colors.black,
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          var result = await showModalBottomSheet(
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
                                child: CreateTaskSheet(widget.todoId),
                              );
                            },
                          );

                          if ((result as bool?) == true) {
                            findTodo = TodosService().findTodo(widget.todoId);
                          }
                          debugPrint(result.toString());
                        },
                        child: const Text("+ Add a task"),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          return const Text("Loading...");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Show a bottom sheet for confirmation.

          // Delete the collection.
          await TodosService().deleteTodo(widget.todoId);

          if (!mounted) {
            return;
          }
          Navigator.pop(context);
        },
        tooltip: 'Delete the collection',
        child: const Icon(Icons.delete_forever),
      ),
    );
  }
}
