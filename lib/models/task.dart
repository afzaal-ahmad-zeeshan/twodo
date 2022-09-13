import 'package:floor/floor.dart';

@Entity(tableName: "todos")
class Todo {
  @primaryKey
  late int id;

  late String title;

  late String when; // DateTime
}
