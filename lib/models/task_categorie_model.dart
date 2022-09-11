import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class TaskCategorieModel {
  Widget icon;
  String type;
  List<TaskModel> tasks;

  TaskCategorieModel(
      {required this.icon, required this.type, required this.tasks});
}
