import 'package:flutter/material.dart';
import 'package:twodo/models/todo.dart';
import 'package:twodo/services/todos_service.dart';

class TodoPage extends StatefulWidget {
  final String todoId;

  TodoPage(this.todoId);

  @override
  State<StatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  String title = "Loading...";
  Future<Todo?>? findTodo;

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
            onPressed: () {},
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
                    return ListTile(
                      leading: Checkbox(
                        value: data.tasks[index].done,
                        onChanged: (value) async {
                          // change the state.
                          var task = data.tasks[index];
                          task.done = value!;
                          await TodosService().updateTask(widget.todoId, task);
                          setState(() {});
                        },
                      ),
                      title: Text(
                        data.tasks[index].title,
                      ),
                      subtitle: data.tasks[index].doBefore.isEmpty
                          ? null
                          : Text(data.tasks[index].doBefore),
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
                      onTap: () {
                        debugPrint("${data.tasks[index].id} was pressed");
                      },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: ElevatedButton(
                        onPressed: () {},
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
          Navigator.pop(context);
        },
        tooltip: 'Delete the collection',
        child: const Icon(Icons.delete_forever),
      ),
    );
  }
}
