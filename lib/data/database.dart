// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:twodo/dao/group_dao.dart';
import 'package:twodo/models/group.dart';

part 'database.g.dart'; // the generated code will be there

@Database(
  version: 1,
  entities: [
    Group,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  GroupDao get groupDao;
}
