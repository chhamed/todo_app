import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/controllers/provider/task_categorie_controller.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/ui/theme/my_text_styles.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;
  final Function? function;
  const TaskWidget({Key? key, required this.task, this.function})
      : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<TaskCategorieController>(context, listen: false);
    return !widget.task.statue
        ? Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: AutoSizeText(
                    widget.task.title,
                    style: MyTextStyles.headline2,
                  ),
                  activeColor: Colors.cyan,
                  value: widget.task.statue,
                  onChanged: (newValue) {
                    p.updateTask(widget.task..statue = true);
                    setState(() {
                      widget.task.statue = newValue!;
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
              SizedBox(
                width: 68.w,
                child: AutoSizeText(
                  widget.task.title,
                  style: MyTextStyles.headline2
                      .copyWith(decoration: TextDecoration.lineThrough),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    widget.function?.call();
                  },
                  icon: const Icon(Icons.delete_outline))
            ],
          );
  }
}
