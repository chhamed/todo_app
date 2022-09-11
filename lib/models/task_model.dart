import 'package:todo_app/models/task_categorie_model.dart';

class TaskModel {
  String title;
  TaskCategorieModel taskCategorieModel;
  bool statue;
  TaskModel(
      {required this.title,
      required this.taskCategorieModel,
      required this.statue});
}
