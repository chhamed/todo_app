class TaskModel {
  String title;
  String taskCategorieModeltype;
  bool statue;
  TaskModel(
      {required this.title,
      required this.taskCategorieModeltype,
      required this.statue});

  static TaskModel fromJson(json) {
    return TaskModel(
        title: json['title'],
        taskCategorieModeltype: json['type'],
        statue: json['statue'] == 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': taskCategorieModeltype,
      'statue': statue ? 1 : 0
    };
  }
}
