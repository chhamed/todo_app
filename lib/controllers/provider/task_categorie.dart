import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

import '../../models/task_categorie_model.dart';

class TaskCategorie extends ChangeNotifier {
  List<TaskCategorieModel> categTasks = [];

  int get getTotalTasks {
    int totalTasks = 0;
    for (var element in categTasks) {
      totalTasks += element.tasks.length;
    }

    return totalTasks;
  }

  int get getActiveTasks {
    int activeTasks = 0;
    for (var element in categTasks) {
      activeTasks +=
          element.tasks.where((element) => element.statue == true).length;
    }
    return activeTasks;
  }

  int get getCompletedTasks {
    int completedTasks = 0;
    for (var element in categTasks) {
      completedTasks +=
          element.tasks.where((element) => element.statue == false).length;
    }
    return completedTasks;
  }

  void addTaskCateg(TaskCategorieModel taskCategorie) {
    categTasks.add(taskCategorie);
    notifyListeners();
  }

  void addTask(TaskCategorieModel taskCategorie, TaskModel task) {
    taskCategorie.tasks.add(task);
    notifyListeners();
  }

  void changeStatue(TaskModel task) {
    task.statue = false;
    notifyListeners();
  }

  void deleteTaskCateg(TaskCategorieModel taskCategorie) {
    categTasks.remove(taskCategorie);
    notifyListeners();
  }

  void deleteTask(TaskCategorieModel taskCategorie, TaskModel task) {
    taskCategorie.tasks.remove(task);
    notifyListeners();
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
        : DragTarget(
            onAccept: (TaskCategorieModel taskCategorie) {
              deleteTaskCateg(taskCategorie);
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
