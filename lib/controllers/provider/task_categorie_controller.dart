import 'package:flutter/material.dart';
import 'package:todo_app/database/sqflite/database.dart';
import 'package:todo_app/models/task_model.dart';

import '../../models/task_categorie_model.dart';

class TaskCategorieController extends ChangeNotifier {
  SqlDb sqlDb = SqlDb();

  Future<List<Map<dynamic, dynamic>>> readTaskCategData() async {
    List<Map> response = await sqlDb.readTaskCategData();
    notifyListeners();
    return response;
  }

  Future<int?> countActive() async {
    int? response = await sqlDb.countAllActiveTasks();
    return response;
  }

  Future<int?> countCompleted() async {
    int? response = await sqlDb.countAllCompletedTasks();
    return response;
  }

  Future<int?> countAll() async {
    int? response = await sqlDb.countAllTasks();
    return response;
  }

  Future<double?> rapport() async {
    double? response = await sqlDb.countCompletedTasks();
    return response;
  }

  Future<List<Map<dynamic, dynamic>>> readActiveDate(
      TaskCategorieModel taskCategorieModel) async {
    List<Map> response = await sqlDb.readActiveTaskDate(taskCategorieModel);
    return response;
  }

  Future<List<Map<dynamic, dynamic>>> readCompletetasks(
      TaskCategorieModel taskCategorieModel) async {
    List<Map> response = await sqlDb.readCompletedTaskDate(taskCategorieModel);

    return response;
  }

  Future<double?> countRappot(TaskCategorieModel taskCategorieModel) async {
    double? response =
        await sqlDb.countCompletedTasksPerCategorie(taskCategorieModel);
    return response;
  }

  Future<int?> countTasks(TaskCategorieModel taskCategorieModel) async {
    int? response = await sqlDb.countTasksPerCategorie(taskCategorieModel);
    return response;
  }

  Future<List<Map<dynamic, dynamic>>> readDate() async {
    List<Map> response = await sqlDb.readTaskDate();
    return response;
  }

  Future<int> updateTask(TaskModel taskModel) async {
    int response = await sqlDb.updatetask(taskModel);
    return response;
  }

  Future<int> deleteTask(TaskModel taskModel) async {
    int response = await sqlDb.deleteTaskData(taskModel);
    notifyListeners();
    return response;
  }

  Future<int> insertTaskData(TaskModel taskModel) async {
    int response = await sqlDb.insertTaskData(taskModel);
    return response;
  }

  Future<int> insertTaskCategorie(TaskCategorieModel taskCategorieModel) async {
    int response = await sqlDb.insertTaskCategData(taskCategorieModel);
    return response;
  }

  bool isDragging = false;

  isDeleting() {
    isDragging = !isDragging;
    notifyListeners();
  }

  floatingActionButton({required Function function}) {
    return isDragging == false
        ? FloatingActionButton(
            backgroundColor: Colors.cyan,
            onPressed: () {
              function();
            },
            child: const Icon(Icons.add),
          )
        : DragTarget<Map<dynamic, dynamic>>(
            onAccept: (Map<dynamic, dynamic> taskCategorie) {
              sqlDb.deleteTaskCategData(
                  TaskCategorieModel.fromJson(taskCategorie).type);

              isDeleting();
            },
            builder: (context, candidateData, rejectedData) =>
                FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                function();
              },
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          );
  }
}
