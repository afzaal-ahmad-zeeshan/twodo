import 'package:floor/floor.dart';

// The individual todo item.
@Entity(tableName: "tasks")
class Task {
  @primaryKey
  late int id;

  late String title;
  late bool done;
  late String doBefore; // DateTime
  late bool favorite;

  late int sequenceOrder;

  late String when; // DateTime
  late int todoId;
}
