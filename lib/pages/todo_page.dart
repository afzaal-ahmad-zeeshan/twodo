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
              ],
            );
          }

          return const Text("Loading...");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Delete',
        child: const Icon(Icons.delete),
      ),
    );
  }
}
