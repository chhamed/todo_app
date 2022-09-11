import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controllers/provider/task_categorie.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/ui/theme/my_text_styles.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<TaskCategorie>(context, listen: false);
    return widget.task.statue
        ? Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: AutoSizeText(
                    widget.task.title,
                    style: MyTextStyles.headline2,
                  ),
                  activeColor: Colors.cyan,
                  value: checkedValue,
                  onChanged: (newValue) {
                    p.changeStatue(widget.task);
                    setState(() {
                      checkedValue = newValue!;
                    });
                  },
                ),
              )
            ],
          )
        : Row(
            children: [
              const Icon(Icons.done),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: AutoSizeText(
                  widget.task.title,
                  style: MyTextStyles.headline2
                      .copyWith(decoration: TextDecoration.lineThrough),
                ),
              ),
            ],
          );
  }
}
