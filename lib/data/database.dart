// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:twodo/dao/group_dao.dart';
import 'package:twodo/dao/task_dao.dart';
import 'package:twodo/dao/todo_dao.dart';
import 'package:twodo/dao/user_dao.dart';
import 'package:twodo/models/group.dart';
import 'package:twodo/models/task.dart';
import 'package:twodo/models/todo.dart';
import 'package:twodo/models/user.dart';

part 'database.g.dart'; // the generated code will be there

@Database(
  version: 1,
  entities: [
    Group,
    Task,
    Todo,
    AppUser,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  GroupDao get groupDao;
  TaskDao get taskDao;
  TodoDao get todoDao;
  UserDao get userDao;
}
