import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_categorie_model.dart';

import '../../controllers/provider/task_categorie.dart';
import '../../models/task_model.dart';
import '../theme/my_text_styles.dart';

class CreateTask extends StatefulWidget {
  final TaskCategorieModel taskCategorieModel;

  const CreateTask({Key? key, required this.taskCategorieModel})
      : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController title = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCategorie>(
      builder: (context, val, child) => Form(
        key: _formKey,
        child: TextFormField(
          controller: title,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }

            for (var t in widget.taskCategorieModel.tasks) {
              if (t.title == value) {
                return 'task already exists';
              }
            }

            return null;
          },
          decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    val.addTask(
                        widget.taskCategorieModel,
                        TaskModel(
                            title: title.text,
                            taskCategorieModel: widget.taskCategorieModel,
                            statue: true));

                    FocusScope.of(context).unfocus();
                    title.clear();
                  }
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
              focusColor: Colors.white,
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan)),
              fillColor: Colors.grey,
              hintText: "title",
              hintStyle: MyTextStyles.hintStyle),
        ),
      ),
    );
  }
}
