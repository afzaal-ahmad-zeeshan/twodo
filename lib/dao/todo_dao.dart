import 'package:floor/floor.dart';
import 'package:twodo/models/task.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM todos')
  Future<List<Task>> getCollections();

  @Query('SELECT * FROM tasks WHERE todoId = :id')
  Future<List<Task>?> findTasksByTodoId(String id);

  @Query('SELECT * FROM tasks WHERE id = :id')
  Future<Task?> findTasksByTaskId(String id);

  @insert
  Future<int> addTask(Task task);

  @update
  Future<int> updateTask(Task task);

  @delete
  Future<int> deleteTask(Task task);
}
