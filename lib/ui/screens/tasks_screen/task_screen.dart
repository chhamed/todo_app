import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/controllers/provider/task_categorie_controller.dart';
import 'package:todo_app/models/task_categorie_model.dart';
import 'package:todo_app/models/task_model.dart';

import 'package:todo_app/ui/theme/my_text_styles.dart';
import 'package:todo_app/ui/widgets/task_widget.dart';
import 'package:todo_app/ui/widgets/create_task.dart';

import '../../../database/sqflite/database.dart';

class TaskListScreen extends StatefulWidget {
  final TaskCategorieModel taskCategorieModel;
  const TaskListScreen({Key? key, required this.taskCategorieModel})
      : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController title = TextEditingController();
  SqlDb sqlDb = SqlDb();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var p = Provider.of<TaskCategorieController>(context, listen: false)
      ..readDate()
      ..readActiveDate(widget.taskCategorieModel)
      ..readCompletetasks(widget.taskCategorieModel);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer<TaskCategorieController>(
          builder: (context, value, child) => Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(widget.taskCategorieModel.icon),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.taskCategorieModel.type,
                          style: MyTextStyles.headline2,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                        future: value.countRappot(widget.taskCategorieModel),
                        builder: (BuildContext context, snapshot) {
                          return ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: LinearProgressIndicator(
                                minHeight: 8,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.cyan),
                                backgroundColor: Colors.grey.withOpacity(0.4),
                                value: snapshot.data == null
                                    ? 0
                                    : snapshot.data as double),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    CreateTask(taskCategorieModel: widget.taskCategorieModel),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Active",
                      style:
                          MyTextStyles.headline2.copyWith(color: Colors.cyan),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        ...List.generate(
                            value.activeTasks.length,
                            (index) => TaskWidget(
                                  task: TaskModel.fromJson(
                                      value.activeTasks[index]),
                                )),
                      ],
                    ),
                    Text(
                      "Completed",
                      style:
                          MyTextStyles.headline2.copyWith(color: Colors.cyan),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        ...List.generate(value.completeTasks.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TaskWidget(
                                task: TaskModel.fromJson(
                                    value.completeTasks[index]),
                                function: () {
                                  value.deleteTask(TaskModel.fromJson(
                                      value.completeTasks[index]));
                                }),
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
