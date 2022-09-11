import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:todo_app/models/task_categorie_model.dart';
import 'package:todo_app/ui/screens/tasks_screen/task_screen.dart';
import 'package:todo_app/ui/theme/my_text_styles.dart';

class CategorieTaskCard extends StatelessWidget {
  final TaskCategorieModel taskCategorie;
  const CategorieTaskCard({Key? key, required this.taskCategorie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskListScreen(
                    taskCategorieModel: taskCategorie,
                  )),
        );
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 30, bottom: 30, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              taskCategorie.icon,
              const SizedBox(
                height: 30,
              ),
              Flexible(
                child: AutoSizeText(
                  taskCategorie.type,
                  maxLines: 2,
                  style: MyTextStyles.headline2,
                ),
              ),
              Text(
                "${taskCategorie.tasks.length} tasks",
                style: MyTextStyles.body.copyWith(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
