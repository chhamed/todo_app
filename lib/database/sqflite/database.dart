import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/task_categorie_model.dart';
import 'package:todo_app/models/task_model.dart';

class SqlDb {
  static Database? _db;

  static Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  static intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'todo.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return mydb;
  }

  Future<void> mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'todo.db');
    await deleteDatabase(path);
  }

  static _onUpgrade(Database db, int oldversion, int newversion) {}

  static _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "categ_tasks" (
    "type" TEXT NOT NULL PRIMARY KEY ,
    "icon" INTEGER ,
    "iconColor" TEXT NOT NULL

  )
 ''');

    await db.execute('''
  CREATE TABLE "task" (
    "title" TEXT  NOT NULL PRIMARY KEY ,
    "statue" INTEGER NOT NULL,
    "type" TEXT NOT NULL
 
  )
 ''');
  }

  insertTaskCategData(TaskCategorieModel taskCategorieModel) async {
    Database? mydb = await db;
    int response =
        await mydb!.insert('categ_tasks', taskCategorieModel.toJson());
    return response;
  }

  insertTaskData(TaskModel taskModel) async {
    Database? mydb = await db;
    int response = await mydb!.insert('task', taskModel.toJson());
    return response;
  }

  readTaskCategData() async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery('SELECT * FROM categ_tasks');
    return response;
  }

  readActiveTaskDate(TaskCategorieModel taskCategorieModel) async {
    Database? mydb = await db;
    List response = await mydb!.rawQuery(
        'SELECT * FROM task where statue = 0 and type = (?)',
        [taskCategorieModel.type]);
    return response;
  }

  readTaskData() async {
    Database? mydb = await db;
    List response = await mydb!.rawQuery('SELECT * FROM task ');
    return response;
  }

  readCompletedTaskData(TaskCategorieModel taskCategorieModel) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(
        'SELECT * FROM task where statue= 1 and type = (?) ',
        [taskCategorieModel.type]);
    return response;
  }

  updateTask(TaskModel taskModel) async {
    Database? mydb = await db;
    int response = await mydb!.update('task', taskModel.toJson(),
        where: 'title=?', whereArgs: [taskModel.title]);
    return response;
  }

  deleteTaskCategData(String type) async {
    Database? mydb = await db;
    int respo =
        await mydb!.rawDelete('DELETE FROM task WHERE TYPE = (?)', [type]);
    int response = await mydb
        .rawDelete('DELETE FROM categ_tasks WHERE TYPE = (?)', [type]);

    return response;
  }

  deleteTaskData(TaskModel taskModel) async {
    Database? mydb = await db;
    int response = await mydb!
        .rawDelete('DELETE FROM task WHERE title = (?)', [taskModel.title]);

    return response;
  }

  Future<int?> countTasksPerCategorie(
      TaskCategorieModel taskCategorieModel) async {
    Database? mydb = await db;
    var x = await mydb!.rawQuery('SELECT COUNT (*) from task where type = (?)',
        [taskCategorieModel.type]);
    int? count = Sqflite.firstIntValue(x);
    return count;
  }

  Future<double?> countCompletedTasksPerCategorie(
      TaskCategorieModel taskCategorieModel) async {
    Database? mydb = await db;
    var x = await mydb!.rawQuery(
        'SELECT COUNT (*) from task where statue = 1 and type = (?)',
        [taskCategorieModel.type]);
    int? countComplted = Sqflite.firstIntValue(x);
    var y = await mydb.rawQuery('SELECT COUNT (*) from task where type = (?)',
        [taskCategorieModel.type]);
    int? countAll = Sqflite.firstIntValue(y);
    double percantage = countComplted! / countAll!;
    return percantage.isNaN ? 0 : percantage;
  }

  Future<int?> countAllActiveTasks() async {
    Database? mydb = await db;
    var x = await mydb!.rawQuery('SELECT COUNT (*) from task where statue = 0');
    int? countActive = Sqflite.firstIntValue(x);

    return countActive;
  }

  Future<int?> countAllCompletedTasks() async {
    Database? mydb = await db;
    var x = await mydb!.rawQuery('SELECT COUNT (*) from task where statue = 1');
    int? countActive = Sqflite.firstIntValue(x);

    return countActive;
  }

  Future<int?> countAllTasks() async {
    Database? mydb = await db;
    var x = await mydb!.rawQuery('SELECT COUNT (*) from task');
    int? countAll = Sqflite.firstIntValue(x);
    return countAll;
  }

  Future<double?> countCompletedTasks() async {
    Database? mydb = await db;
    var x =
        await mydb!.rawQuery('SELECT COUNT (*) from task where statue = 1 ');
    int? countComplted = Sqflite.firstIntValue(x);
    var y = await mydb.rawQuery('SELECT COUNT (*) from task');
    int? countAll = Sqflite.firstIntValue(y);
    double percantage = countComplted! / countAll!;

    return percantage.isNaN ? 0 : percantage;
  }
}
