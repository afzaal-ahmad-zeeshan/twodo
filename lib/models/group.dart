import 'package:floor/floor.dart';

// groups are always between two!
@Entity(tableName: "groups")
class Group {
  @primaryKey
  late int id;

  late String title;

  late String when; // DateTime
  late bool favorite;
  late int sequenceOrder;

  // database structure
  late String owner;
  late String userId;
}
