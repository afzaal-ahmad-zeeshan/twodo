// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GroupDao? _groupDaoInstance;

  TaskDao? _taskDaoInstance;

  TodoDao? _todoDaoInstance;

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `groups` (`id` TEXT NOT NULL, `title` TEXT NOT NULL, `when` TEXT NOT NULL, `favorite` INTEGER NOT NULL, `sequenceOrder` INTEGER NOT NULL, `owner` TEXT NOT NULL, `collaborator` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tasks` (`id` TEXT NOT NULL, `title` TEXT NOT NULL, `done` INTEGER NOT NULL, `doBefore` TEXT NOT NULL, `favorite` INTEGER NOT NULL, `sequenceOrder` INTEGER NOT NULL, `when` TEXT NOT NULL, `todoId` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `todos` (`id` TEXT NOT NULL, `title` TEXT NOT NULL, `when` TEXT NOT NULL, `groupId` TEXT NOT NULL, `favorite` INTEGER NOT NULL, `sequenceOrder` INTEGER NOT NULL, `privateCollection` INTEGER NOT NULL, `colorAccent` TEXT NOT NULL, `deleteWhenDone` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` TEXT NOT NULL, `email` TEXT NOT NULL, `userId` TEXT NOT NULL, `offlineUser` INTEGER NOT NULL, `when` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GroupDao get groupDao {
    return _groupDaoInstance ??= _$GroupDao(database, changeListener);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$GroupDao extends GroupDao {
  _$GroupDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _groupInsertionAdapter = InsertionAdapter(
            database,
            'groups',
            (Group item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'when': item.when,
                  'favorite': item.favorite ? 1 : 0,
                  'sequenceOrder': item.sequenceOrder,
                  'owner': item.owner,
                  'collaborator': item.collaborator
                }),
        _groupUpdateAdapter = UpdateAdapter(
            database,
            'groups',
            ['id'],
            (Group item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'when': item.when,
                  'favorite': item.favorite ? 1 : 0,
                  'sequenceOrder': item.sequenceOrder,
                  'owner': item.owner,
                  'collaborator': item.collaborator
                }),
        _groupDeletionAdapter = DeletionAdapter(
            database,
            'groups',
            ['id'],
            (Group item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'when': item.when,
                  'favorite': item.favorite ? 1 : 0,
                  'sequenceOrder': item.sequenceOrder,
                  'owner': item.owner,
                  'collaborator': item.collaborator
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Group> _groupInsertionAdapter;

  final UpdateAdapter<Group> _groupUpdateAdapter;

  final DeletionAdapter<Group> _groupDeletionAdapter;

  @override
  Future<List<Group>> getAllGroups() async {
    return _queryAdapter.queryList('SELECT * FROM groups',
        mapper: (Map<String, Object?> row) => Group(
            row['id'] as String,
            row['title'] as String,
            row['when'] as String,
            (row['favorite'] as int) != 0,
            row['sequenceOrder'] as int,
            row['owner'] as String,
            row['collaborator'] as String));
  }

  @override
  Future<Group?> findGroupById(String id) async {
    return _queryAdapter.query('SELECT * FROM groups WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Group(
            row['id'] as String,
            row['title'] as String,
            row['when'] as String,
            (row['favorite'] as int) != 0,
            row['sequenceOrder'] as int,
            row['owner'] as String,
            row['collaborator'] as String),
        arguments: [id]);
  }

  @override
  Future<int> addGroup(Group group) {
    return _groupInsertionAdapter.insertAndReturnId(
        group, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateGroup(Group group) {
    return _groupUpdateAdapter.updateAndReturnChangedRows(
        group, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteGroup(Group group) {
    return _groupDeletionAdapter.deleteAndReturnChangedRows(group);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'tasks',
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'done': item.done ? 1 : 0,
                  'doBefore': item.doBefore,
                  'favorite': item.favorite ? 1 : 0,
                  'sequenceOrder': item.sequenceOrder,
                  'when': item.when,
                  'todoId': item.todoId
                }),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'tasks',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'done': item.done ? 1 : 0,
                  'doBefore': item.doBefore,
                  'favorite': item.favorite ? 1 : 0,
                  'sequenceOrder': item.sequenceOrder,
                  'when': item.when,
                  'todoId': item.todoId
                }),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'tasks',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'done': item.done ? 1 : 0,
                  'doBefore': item.doBefore,
                  'favorite': item.favorite ? 1 : 0,
                  'sequenceOrder': item.sequenceOrder,
                  'when': item.when,
                  'todoId': item.todoId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final UpdateAdapter<Task> _taskUpdateAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Future<List<Task>> getAllTasks() async {
    return _queryAdapter.queryList('SELECT * FROM tasks',
        mapper: (Map<String, Object?> row) => Task(
            row['id'] as String,
            row['title'] as String,
            (row['done'] as int) != 0,
            row['doBefore'] as String,
            (row['favorite'] as int) != 0,
            row['sequenceOrder'] as int,
            row['when'] as String,
            row['todoId'] as int));
  }

  @override
  Future<List<Task>?> findTasksByGroupId(String id) async {
    return _queryAdapter.queryList('SELECT * FROM tasks WHERE groupId = ?1',
        mapper: (Map<String, Object?> row) => Task(
            row['id'] as String,
            row['title'] as String,
            (row['done'] as int) != 0,
            row['doBefore'] as String,
            (row['favorite'] as int) != 0,
            row['sequenceOrder'] as int,
            row['when'] as String,
            row['todoId'] as int),
        arguments: [id]);
  }

  @override
  Future<Task?> findTasksByTaskId(String id) async {
    return _queryAdapter.query('SELECT * FROM tasks WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Task(
            row['id'] as String,
            row['title'] as String,
            (row['done'] as int) != 0,
            row['doBefore'] as String,
            (row['favorite'] as int) != 0,
            row['sequenceOrder'] as int,
            row['when'] as String,
            row['todoId'] as int),
        arguments: [id]);
  }

  @override
  Future<int> addTask(Task task) {
    return _taskInsertionAdapter.insertAndReturnId(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateTask(Task task) {
    return _taskUpdateAdapter.updateAndReturnChangedRows(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteTask(Task task) {
    return _taskDeletionAdapter.deleteAndReturnChangedRows(task);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'tasks',
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'done': item.done ? 1 : 0,
                  'doBefore': item.doBefore,
                  'favorite': item.favorite ? 1 : 0,
                  'sequenceOrder': item.sequenceOrder,
                  'when': item.when,
                  'todoId': item.todoId
                }),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'tasks',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'done': item.done ? 1 : 0,
                  'doBefore': item.doBefore,
                  'favorite': item.favorite ? 1 : 0,
                  'sequenceOrder': item.sequenceOrder,
                  'when': item.when,
                  'todoId': item.todoId
                }),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'tasks',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'done': item.done ? 1 : 0,
                  'doBefore': item.doBefore,
                  'favorite': item.favorite ? 1 : 0,
                  'sequenceOrder': item.sequenceOrder,
                  'when': item.when,
                  'todoId': item.todoId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final UpdateAdapter<Task> _taskUpdateAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Future<List<Task>> getCollections() async {
    return _queryAdapter.queryList('SELECT * FROM todos',
        mapper: (Map<String, Object?> row) => Task(
            row['id'] as String,
            row['title'] as String,
            (row['done'] as int) != 0,
            row['doBefore'] as String,
            (row['favorite'] as int) != 0,
            row['sequenceOrder'] as int,
            row['when'] as String,
            row['todoId'] as int));
  }

  @override
  Future<List<Task>?> findTasksByTodoId(String id) async {
    return _queryAdapter.queryList('SELECT * FROM tasks WHERE todoId = ?1',
        mapper: (Map<String, Object?> row) => Task(
            row['id'] as String,
            row['title'] as String,
            (row['done'] as int) != 0,
            row['doBefore'] as String,
            (row['favorite'] as int) != 0,
            row['sequenceOrder'] as int,
            row['when'] as String,
            row['todoId'] as int),
        arguments: [id]);
  }

  @override
  Future<Task?> findTasksByTaskId(String id) async {
    return _queryAdapter.query('SELECT * FROM tasks WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Task(
            row['id'] as String,
            row['title'] as String,
            (row['done'] as int) != 0,
            row['doBefore'] as String,
            (row['favorite'] as int) != 0,
            row['sequenceOrder'] as int,
            row['when'] as String,
            row['todoId'] as int),
        arguments: [id]);
  }

  @override
  Future<int> addTask(Task task) {
    return _taskInsertionAdapter.insertAndReturnId(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateTask(Task task) {
    return _taskUpdateAdapter.updateAndReturnChangedRows(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteTask(Task task) {
    return _taskDeletionAdapter.deleteAndReturnChangedRows(task);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _appUserInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (AppUser item) => <String, Object?>{
                  'id': item.id,
                  'email': item.email,
                  'userId': item.userId,
                  'offlineUser': item.offlineUser ? 1 : 0,
                  'when': item.when
                }),
        _appUserUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['id'],
            (AppUser item) => <String, Object?>{
                  'id': item.id,
                  'email': item.email,
                  'userId': item.userId,
                  'offlineUser': item.offlineUser ? 1 : 0,
                  'when': item.when
                }),
        _appUserDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['id'],
            (AppUser item) => <String, Object?>{
                  'id': item.id,
                  'email': item.email,
                  'userId': item.userId,
                  'offlineUser': item.offlineUser ? 1 : 0,
                  'when': item.when
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AppUser> _appUserInsertionAdapter;

  final UpdateAdapter<AppUser> _appUserUpdateAdapter;

  final DeletionAdapter<AppUser> _appUserDeletionAdapter;

  @override
  Future<List<Task>> getProfiles() async {
    return _queryAdapter.queryList('SELECT * FROM users',
        mapper: (Map<String, Object?> row) => Task(
            row['id'] as String,
            row['title'] as String,
            (row['done'] as int) != 0,
            row['doBefore'] as String,
            (row['favorite'] as int) != 0,
            row['sequenceOrder'] as int,
            row['when'] as String,
            row['todoId'] as int));
  }

  @override
  Future<Task?> findUserById(String id) async {
    return _queryAdapter.query('SELECT * FROM users WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Task(
            row['id'] as String,
            row['title'] as String,
            (row['done'] as int) != 0,
            row['doBefore'] as String,
            (row['favorite'] as int) != 0,
            row['sequenceOrder'] as int,
            row['when'] as String,
            row['todoId'] as int),
        arguments: [id]);
  }

  @override
  Future<int> addUser(AppUser user) {
    return _appUserInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateUser(AppUser user) {
    return _appUserUpdateAdapter.updateAndReturnChangedRows(
        user, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteUser(AppUser user) {
    return _appUserDeletionAdapter.deleteAndReturnChangedRows(user);
  }
}
