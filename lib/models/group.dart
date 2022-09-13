import 'package:floor/floor.dart';

@Entity(tableName: "groups")
class Group {
  @primaryKey
  late int id;

  late String title;

  late String when; // DateTime
}
