import 'package:twodo/models/task.dart';

// The collection of todos.
class Todo {
  late String id;

  late String title;

  late bool favorite;
  late int order;
  late List<dynamic> owners;

  late List<Task> tasks;

  // style
  late String colorAccent;
  late bool deleteWhenDone;

  Todo(
    this.id,
    this.title,
    this.favorite,
    this.order,
    this.owners,
    this.tasks,
    this.colorAccent,
    this.deleteWhenDone,
  );

  Todo.empty()
      : id = "",
        title = "",
        favorite = false,
        order = 1,
        owners = [],
        tasks = [],
        colorAccent = "red",
        deleteWhenDone = true;

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id']! as String,
        title = json['title']! as String,
        favorite = json["favorite"]! as bool,
        order = json["order"]! as int,
        owners = json["owners"]! as List<dynamic>,
        tasks = (json["tasks"]! as List<dynamic>)
            .map((e) => Task.fromJson(e))
            .toList(),
        colorAccent = json["colorAccent"]! as String,
        deleteWhenDone = json["deleteWhenDone"]! as bool;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "favorite": favorite,
      "order": order,
      "owners": owners,
      "tasks": tasks.map((e) => e.toJson()).toList(),
      "colorAccent": colorAccent,
      "deleteWhenDone": deleteWhenDone,
    };
  }
}
