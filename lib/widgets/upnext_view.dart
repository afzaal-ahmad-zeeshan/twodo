import 'package:flutter/material.dart';
import 'package:twodo/models/task.dart';
import 'package:twodo/models/todo.dart';
import 'package:twodo/services/todos_service.dart';
import 'package:uuid/uuid.dart';

class UpNextView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpNextViewState();
}

class _UpNextViewState extends State<UpNextView> {
  TodosService service = TodosService();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              service.addTask(
                "58d25beb-a9b4-4600-b72c-d1615999098e",
                Task(
                  Uuid().v4(),
                  "New task",
                  false,
                  "01-01-31",
                  true,
                  4,
                ),
              );
            },
            child: const Text("Add a task"),
          ),
          TextButton(
            onPressed: () {
              service.updateTask(
                "6c9d6caf-c346-4085-9536-769d816f0fa7",
                Task(
                  "d625c252-bcff-454c-a9ba-e1e7a1bbd700",
                  "Task updated",
                  false,
                  "01-01-31",
                  true,
                  4,
                ),
              );
            },
            child: const Text("Update task"),
          ),
          TextButton(
            onPressed: () {
              service.deleteTask(
                "6c9d6caf-c346-4085-9536-769d816f0fa7",
                "d625c252-bcff-454c-a9ba-e1e7a1bbd700",
              );
            },
            child: const Text("Delete task"),
          ),
          // TextButton(
          //   onPressed: () {
          //     service.addTodo(
          //       Todo(
          //         const Uuid().v4(),
          //         "First todo",
          //         true,
          //         1,
          //         ["foo", "bar"],
          //         [
          //           Task(
          //             Uuid().v4(),
          //             "Task 1",
          //             true,
          //             "",
          //             true,
          //             1,
          //           ),
          //           Task(
          //             Uuid().v4(),
          //             "Task 2",
          //             true,
          //             "",
          //             true,
          //             1,
          //           ),
          //         ],
          //         "blue",
          //         true,
          //       ),
          //     );
          //   },
          //   child: const Text("Add"),
          // ),
          // TextButton(
          //   onPressed: () {
          //     service.findTodo(true);
          //   },
          //   child: const Text("Find todo"),
          // ),
          // TextButton(
          //   onPressed: () {
          //     service.getTodos();
          //   },
          //   child: const Text("Find all"),
          // ),
          // TextButton(
          //   onPressed: () {
          //     service.updateTodo(
          //       "4593d81e-164b-41fe-b62d-160fe3cd828a",
          //       Todo(
          //         const Uuid().v4(),
          //         "First todo",
          //         false,
          //         1,
          //         ["foo", "bar"],
          //         [
          //           Task(
          //             Uuid().v4(),
          //             "Task 1",
          //             true,
          //             "",
          //             true,
          //             1,
          //           ),
          //         ],
          //         "red",
          //         true,
          //       ),
          //     );
          //   },
          //   child: const Text("Update"),
          // ),
          // TextButton(
          //   onPressed: () {
          //     service.deleteTodo("07ef1263-c9fc-41d7-b09a-ac90ececc3d1");
          //   },
          //   child: const Text("Delete"),
          // ),
        ],
      ),
    );
  }
}
