import 'package:floor/floor.dart';

class User {
  @primaryKey
  late int id;

  late String email;
  late String userId;
  late bool offlineUser;

  late String when;
}