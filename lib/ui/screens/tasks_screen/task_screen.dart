import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/controllers/provider/task_categorie.dart';
import 'package:todo_app/models/task_categorie_model.dart';

import 'package:todo_app/ui/theme/my_text_styles.dart';
import 'package:todo_app/ui/widgets/task_widget.dart';
import 'package:todo_app/ui/widgets/create_task.dart';

class TaskListScreen extends StatefulWidget {
  final TaskCategorieModel taskCategorieModel;
  const TaskListScreen({Key? key, required this.taskCategorieModel})
      : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<TaskCategorie>(
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
                      widget.taskCategorieModel.icon,
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
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                      backgroundColor: Colors.grey,
                      value: ((value.categTasks
                                      .firstWhere((element) =>
                                          element == widget.taskCategorieModel)
                                      .tasks
                                      .where(
                                        (element) => element.statue == false,
                                      )
                                      .length) /
                                  (value.categTasks
                                      .firstWhere((element) =>
                                          element == widget.taskCategorieModel)
                                      .tasks
                                      .length))
                              .isNaN
                          ? 0
                          : (value.categTasks
                                  .firstWhere((element) =>
                                      element == widget.taskCategorieModel)
                                  .tasks
                                  .where(
                                    (element) => element.statue == false,
                                  )
                                  .length) /
                              (value.categTasks
                                  .firstWhere((element) =>
                                      element == widget.taskCategorieModel)
                                  .tasks
                                  .length),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CreateTask(taskCategorieModel: widget.taskCategorieModel),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Active",
                    style: MyTextStyles.headline2.copyWith(color: Colors.cyan),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...List.generate(
                      widget.taskCategorieModel.tasks.length,
                      (index) =>
                          widget.taskCategorieModel.tasks[index].statue == true
                              ? TaskWidget(
                                  task: widget.taskCategorieModel.tasks[index])
                              : const SizedBox()),
                  Text(
                    "Completed",
                    style: MyTextStyles.headline2.copyWith(color: Colors.cyan),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...List.generate(widget.taskCategorieModel.tasks.length,
                      (index) {
                    return widget.taskCategorieModel.tasks[index].statue ==
                            false
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Dismissible(
                              direction: DismissDirection.endToStart,
                              key: Key(index.toString()),
                              onDismissed: (direction) {
                                value.deleteTask(widget.taskCategorieModel,
                                    widget.taskCategorieModel.tasks[index]);
                              },
                              background: Container(
                                color: Colors.red,
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              child: TaskWidget(
                                  task: widget.taskCategorieModel.tasks[index]),
                            ),
                          )
                        : const SizedBox();
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
