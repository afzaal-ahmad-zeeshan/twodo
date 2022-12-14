import 'package:floor/floor.dart';
import 'package:twodo/models/task.dart';
import 'package:twodo/models/user.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM users')
  Future<List<Task>> getProfiles();

  @Query('SELECT * FROM users WHERE id = :id')
  Future<Task?> findUserById(String id);

  @insert
  Future<int> addUser(AppUser user);

  @update
  Future<int> updateUser(AppUser user);

  @delete
  Future<int> deleteUser(AppUser user);
}
