import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class TaskCategorieModel {
  IconData icon;
  String type;
  String color;
  List<TaskModel> tasks;

  TaskCategorieModel(
      {required this.icon,
      required this.type,
      this.tasks = const [],
      required this.color});

  static TaskCategorieModel fromJson(json) {
    return TaskCategorieModel(
        type: json['type'],
        icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
        color: json['iconColor']);
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'icon': icon.codePoint, 'iconColor': color};
  }
}
