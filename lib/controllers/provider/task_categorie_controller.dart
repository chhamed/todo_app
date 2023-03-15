import 'package:flutter/material.dart';
import 'package:todo_app/database/sqflite/database.dart';
import 'package:todo_app/models/task_model.dart';

import '../../models/task_categorie_model.dart';

class TaskCategorieController extends ChangeNotifier {
  SqlDb sqlDb = SqlDb();

  List<Map<dynamic, dynamic>> taskCategories = [];
  Future readTaskCategData() async {
    List<Map> response = await sqlDb.readTaskCategData();
    taskCategories = response;
    notifyListeners();
  }

  int activeCount = 0;
  int completedCount = 0;
  int allCount = 0;
  Future countActive() async {
    int? response = await sqlDb.countAllActiveTasks();
    activeCount = response ?? 0;
    notifyListeners();
  }

  Future countCompleted() async {
    int? response = await sqlDb.countAllCompletedTasks();
    completedCount = response ?? 0;
    notifyListeners();
  }

  Future countAll() async {
    int? response = await sqlDb.countAllTasks();
    allCount = response ?? 0;
    notifyListeners();
  }

  double? completedTasksCount;

  Future rapport() async {
    double? response = await sqlDb.countCompletedTasks();
    completedTasksCount = response;
    notifyListeners();
  }

  List<Map<dynamic, dynamic>> activeTasks = [];
  Future readActiveDate(TaskCategorieModel taskCategorieModel) async {
    List<Map> response = await sqlDb.readActiveTaskDate(taskCategorieModel);
    activeTasks = response;
    notifyListeners();
  }

  double? countCompeltedTasksCategorie;
  Future countRappot(TaskCategorieModel taskCategorieModel) async {
    double? response =
        await sqlDb.countCompletedTasksPerCategorie(taskCategorieModel);
    countCompeltedTasksCategorie = response;
    notifyListeners();
  }

  int allTasks = 0;
  Future countTasks(TaskCategorieModel taskCategorieModel) async {
    int? response = await sqlDb.countTasksPerCategorie(taskCategorieModel);
    allTasks = response ?? 0;
    notifyListeners();
  }

  List<Map<dynamic, dynamic>> completeTasks = [];

  Future readCompletetasks(TaskCategorieModel taskCategorieModel) async {
    List<Map> response = await sqlDb.readCompletedTaskData(taskCategorieModel);
    completeTasks = response;
    notifyListeners();
  }

  List<Map<dynamic, dynamic>> tasksData = [];

  Future readDate() async {
    List<Map> response = await sqlDb.readTaskData();
    tasksData = response;
    notifyListeners();
  }

  Future<int> updateTask(TaskModel taskModel) async {
    int response = await sqlDb.updateTask(taskModel);
    notifyListeners();
    return response;
  }

  Future<int> deleteTask(TaskModel taskModel) async {
    int response = await sqlDb.deleteTaskData(taskModel);
    notifyListeners();
    return response;
  }

  Future<int> insertTaskData(TaskModel taskModel) async {
    int response = await sqlDb.insertTaskData(taskModel);
    notifyListeners();
    return response;
  }

  Future<int> insertTaskCategorie(TaskCategorieModel taskCategorieModel) async {
    int response = await sqlDb.insertTaskCategData(taskCategorieModel);

    notifyListeners();
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
