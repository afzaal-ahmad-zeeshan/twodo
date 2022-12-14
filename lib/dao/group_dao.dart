import 'package:floor/floor.dart';
import 'package:twodo/models/group.dart';

@dao
abstract class GroupDao {
  @Query('SELECT * FROM groups')
  Future<List<Group>> getAllGroups();

  @Query('SELECT * FROM groups WHERE id = :id')
  Future<Group?> findGroupById(String id);

  @insert
  Future<int> addGroup(Group group);

  @update
  Future<int> updateGroup(Group group);

  @delete
  Future<int> deleteGroup(Group group);
}
