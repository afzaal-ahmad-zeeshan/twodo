import 'package:floor/floor.dart';

// The collection of todos.
@Entity(tableName: "todos")
class Todo {
  @primaryKey
  late int id;

  late String title;

  late String when; // DateTime
  late String groupId;
  late bool favorite;
  late int sequenceOrder;

  late bool privateCollection;

  // style
  late String colorAccent;
  late bool deleteWhenDone;
}
