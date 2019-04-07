import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String tableTodo = "todo";
final String columnId = "_id";
final String columnTitle = "title";
final String columnDone = "done";

class Todo {
  int id;
  String title;
  bool done;

  Todo({String title, bool done, id}) {
    this.title = title;
    this.done = done;
    this.id = id;
  }
  factory Todo.fromMap(Map<String, dynamic> map) => new Todo(
        id: map[columnId],
        title: map[columnTitle],
        done: map[columnDone] == 1,
      );
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnDone: done == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }
}

class TodoProvider {
  static final TodoProvider db = TodoProvider();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await openDB();
      return _database;
    }
  }

  Future openDB() async {
    var dbpath = await getDatabasesPath();
    String path = dbpath + "\todo.db";
    return await openDatabase(path, version: 1,
        onCreate: (Database _database, int version) async {
      await _database.execute(
          '''create table $tableTodo ($columnId integer primary key autoincrement, $columnTitle text not null,$columnDone integer not null)''');
    });
  }

  Future<List<Todo>> getAllTodoDones() async {
    final _database = await database;
    var result = await _database.query(tableTodo, where: '$columnDone = 1');
    List<Todo> list = result.map((d) => Todo.fromMap(d)).toList();
    return list;
  }

  Future<List<Todo>> getAllTodoNotDones() async {
    final _database = await database;
    var result = await _database.query(tableTodo, where: '$columnDone = 0');
    List<Todo> list = result.map((d) => Todo.fromMap(d)).toList();
    return list;
  }

  Future<Todo> insert(Todo todo) async {
    final _database = await database;
    todo.id = await _database.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<int> deleteDones() async {
    final _database = await database;
    return _database.delete(tableTodo, where: '$columnDone = 1');
  }

  Future<int> update(Todo todo) async {
    final _database = await database;
    return _database.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => _database.close();
}
