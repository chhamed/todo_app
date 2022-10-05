import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/sqflite/database.dart';
import 'package:todo_app/models/task_categorie_model.dart';

import '../../controllers/provider/task_categorie_controller.dart';
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
  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCategorieController>(
      builder: (context, val, child) => Form(
        key: _formKey,
        child: FutureBuilder(
            future: val.readDate(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<dynamic, dynamic>>> snapshot) {
              return TextFormField(
                controller: title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  var keys = snapshot.data;
                  if (snapshot.data != null) {
                    for (var categ in keys!) {
                      if (categ['title'] == value) {
                        return 'task already exists';
                      }
                    }
                  }

                  return null;
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          val.insertTaskData(TaskModel(
                              title: title.text,
                              taskCategorieModeltype:
                                  widget.taskCategorieModel.type,
                              statue: false));

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
              );
            }),
      ),
    );
  }
}
