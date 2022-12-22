import 'package:floor/floor.dart';

// The collection of todos.
@Entity(tableName: "todos")
class Todo {
  @primaryKey
  late String id;

  late String title;

  late bool favorite;
  late int order;
  late List<dynamic> owners;

  // style
  late String colorAccent;
  late bool deleteWhenDone;

  Todo(
    this.id,
    this.title,
    this.favorite,
    this.order,
    this.owners,
    this.colorAccent,
    this.deleteWhenDone,
  );

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id']! as String,
        title = json['title']! as String,
        favorite = json["favorite"]! as bool,
        order = json["order"]! as int,
        owners = json["owners"]! as List<dynamic>,
        colorAccent = json["colorAccent"]! as String,
        deleteWhenDone = json["deleteWhenDone"]! as bool;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "favorite": favorite,
      "order": order,
      "owners": owners,
      "colorAccent": colorAccent,
      "deleteWhenDone": deleteWhenDone,
    };
  }
}
