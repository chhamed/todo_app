import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controllers/provider/task_categorie_controller.dart';

import 'package:todo_app/models/task_categorie_model.dart';
import 'package:todo_app/ui/screens/tasks_screen/task_screen.dart';
import 'package:todo_app/ui/theme/my_text_styles.dart';

class CategorieTaskCard extends StatefulWidget {
  final TaskCategorieModel taskCategorie;
  const CategorieTaskCard({Key? key, required this.taskCategorie})
      : super(key: key);

  @override
  State<CategorieTaskCard> createState() => _CategorieTaskCardState();
}

class _CategorieTaskCardState extends State<CategorieTaskCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var p = Provider.of<TaskCategorieController>(context, listen: false)
      ..countTasks(widget.taskCategorie);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskListScreen(
                    taskCategorieModel: widget.taskCategorie,
                  )),
        );
      },
      child: Consumer<TaskCategorieController>(
        builder: (context, value, child) => Card(
          elevation: 3,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 30, bottom: 30, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  widget.taskCategorie.icon,
                  color: Color(int.parse(widget.taskCategorie.color)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Flexible(
                  child: AutoSizeText(
                    widget.taskCategorie.type,
                    maxLines: 2,
                    style: MyTextStyles.headline2,
                  ),
                ),
                Text(
                  "${value.allTasks} tasks",
                  style: MyTextStyles.body.copyWith(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
