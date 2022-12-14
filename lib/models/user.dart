import 'package:floor/floor.dart';

@Entity(tableName: "users")
class AppUser {
  @primaryKey
  late String id;

  late String email;
  late String userId;
  late bool offlineUser;

  late String when;
}
