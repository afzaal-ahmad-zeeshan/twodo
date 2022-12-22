import 'package:flutter/material.dart';
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
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              service.addTodo(
                Todo(
                  const Uuid().v4(),
                  "First todo",
                  true,
                  1,
                  ["foo", "bar"],
                  // [],
                  "blue",
                  true,
                ),
              );
            },
            child: const Text("Add todo"),
          ),
          TextButton(
            onPressed: () {
              service.findTodo(true);
            },
            child: const Text("Find todo"),
          ),
          TextButton(
            onPressed: () {
              service.getTodos();
            },
            child: const Text("Find all"),
          ),
          TextButton(
            onPressed: () {
              service.updateTodo(
                "3330a97c-f3e1-426c-9732-455ad4667233",
                Todo(
                  const Uuid().v4(),
                  "First todo",
                  false,
                  1,
                  ["foo", "bar"],
                  // [],
                  "red",
                  true,
                ),
              );
            },
            child: const Text("Update todo"),
          ),
          TextButton(
            onPressed: () {
              service.deleteTodo("07ef1263-c9fc-41d7-b09a-ac90ececc3d1");
            },
            child: const Text("Delete todo"),
          ),
        ],
      ),
    );
  }
}
