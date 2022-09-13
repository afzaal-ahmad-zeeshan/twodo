import 'package:floor/floor.dart';
import 'package:twodo/models/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM tasks')
  Future<List<Task>> getAllTasks();

  @Query('SELECT * FROM tasks WHERE groupId = :id')
  Future<List<Task>?> findTasksByGroupId(int id);

  @Query('SELECT * FROM tasks WHERE id = :id')
  Future<Task?> findTasksByTaskId(int id);

  @insert
  Future<int> addTask(Task task);

  @update
  Future<int> updateTask(Task task);

  @delete
  Future<int> deleteTask(Task task);
}
