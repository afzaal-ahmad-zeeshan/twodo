import 'package:floor/floor.dart';

// The individual todo item.
@Entity(tableName: "tasks")
class Task {
  @primaryKey
  late String id;

  late String title;
  late bool done;
  late String doBefore; // DateTime
  late bool favorite;

  late int sequenceOrder;

  late String when; // DateTime
  late int todoId;

  Task(
    this.id,
    this.title,
    this.done,
    this.doBefore,
    this.favorite,
    this.sequenceOrder,
    this.when,
    this.todoId,
  );
}
