import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/models/task_categorie_model.dart';
import 'package:todo_app/ui/theme/my_text_styles.dart';
import 'package:todo_app/ui/widgets/icon_list.dart';

import '../../../controllers/provider/task_categorie.dart';

class AddTaskCateg extends StatefulWidget {
  const AddTaskCateg({Key? key}) : super(key: key);

  @override
  State<AddTaskCateg> createState() => _AddTaskCategState();
}

class _AddTaskCategState extends State<AddTaskCateg> {
  TextEditingController type = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int currentColorIndex = 0;

  switchIndex(int index) {
    currentColorIndex = index;
    setState(() {});
  }

  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<TaskCategorie>(
        builder: (context, val, child) => AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Builder(
            builder: (context) {
              return SizedBox(
                height: 50.h,
                width: 80.w,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Task type",
                          style: MyTextStyles.headline2,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: type,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              for (var categ in val.categTasks) {
                                if (categ.type == value) {
                                  return 'type already exists';
                                }
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.cyan, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Title",
                                hintStyle: MyTextStyles.hintStyle),
                          ),
                        ),
                      ),
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 60,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: IconList.iconList.length,
                          itemBuilder: (_, index) => Opacity(
                                opacity: currentColorIndex == index ? 0.4 : 1,
                                child: IconButton(
                                  iconSize: 30,
                                  icon: Icon(
                                    IconList.iconList[index],
                                    color: IconList.iconColors[index],
                                  ),
                                  onPressed: () {
                                    selectedIcon = IconList.iconList[index];
                                    switchIndex(index);
                                  },
                                ),
                              )),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<TaskCategorie>(
                        builder: (context, value, child) => InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              value.addTaskCateg(TaskCategorieModel(
                                  icon: Icon(
                                    selectedIcon ?? IconList.iconList[0],
                                    color:
                                        IconList.iconColors[currentColorIndex],
                                  ),
                                  type: type.text,
                                  tasks: []));
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: 7.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.cyan,
                            ),
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: MyTextStyles.buttonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
