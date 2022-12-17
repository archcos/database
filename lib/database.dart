import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataModel {
  int id;
  int? userId;
  String? title;
  String? completed;
  DataModel({required this.id, this.userId, this.title, this.completed});

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
      id: json['id'], userId: json['userId'], title: json['title'], completed: json['completed']);

  Map<String, dynamic> toMap() => {
    "id": id,
    "userId": userId,
    "title": title,
    "completed": completed,
  };
}

class NewDatabase {

    initDB() async {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, 'new_todos.db');

      var database = await openDatabase(
          path, version: 1, onCreate: createDatabase);
      return database;
    }
      createDatabase(Database database, int version) async {
      await database.execute(
          'CREATE TABLE MYTable (id INTEGER PRIMARY KEY, userId INTEGER NOT NULL, title TEXT NOT NULL, completed TEXT NOT NULL)');
      }

  Future<bool> insertData(DataModel dataModel) async {
    final Database database = await initDB();
    database.insert("MYTable", dataModel.toMap());
    return true;
  }

  Future<List<DataModel>> getData() async {
    final Database database = await initDB();
    final List<Map<String, Object?>> data = await database.query("MYTable");
    return data.map((e) => DataModel.fromMap(e)).toList();
  }

  Future<bool> update(DataModel dataModel, int id) async {
    final Database database = await initDB();
    await database.update("MYTable", dataModel.toMap(), where: "id=?", whereArgs: [id]);
    return true;
  }

  Future<void> delete(int id) async {
    final Database database = await initDB();
    await database.delete("MYTable", where: "id=?", whereArgs: [id]);
  }

}
