import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:todo_app/models/task_categorie_model.dart';

import '../../../controllers/provider/task_categorie_controller.dart';
import '../../theme/my_text_styles.dart';
import '../../widgets/categorie_task_card.dart';

class TaskCategList extends StatefulWidget {
  const TaskCategList({Key? key}) : super(key: key);

  @override
  State<TaskCategList> createState() => _TaskCategListState();
}

class _TaskCategListState extends State<TaskCategList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TaskCategorieController>(context, listen: false)
        .readTaskCategData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<TaskCategorieController>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "My Lists",
                style: MyTextStyles.headline1,
              ),
              Consumer<TaskCategorieController>(
                builder: (context, value, child) {
                  return value.taskCategories.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Image.asset(
                                "assets/images/empty.png",
                              ),
                              Text(
                                "No categories yet !",
                                style: MyTextStyles.subhead
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 30.h,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: value.taskCategories.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Draggable<Map<dynamic, dynamic>>(
                                onDragStarted: () {
                                  value.isDeleting();
                                },
                                onDraggableCanceled: (_, p) {
                                  value.isDeleting();
                                },
                                data: value.taskCategories[index],
                                feedback: SizedBox(
                                  height: 30.h - 20,
                                  width: 50.w - 20,
                                  child: Opacity(
                                    opacity: 0.6,
                                    child: CategorieTaskCard(
                                      taskCategorie:
                                          TaskCategorieModel.fromJson(
                                              value.taskCategories[index]),
                                    ),
                                  ),
                                ),
                                child: CategorieTaskCard(
                                  taskCategorie: TaskCategorieModel.fromJson(
                                      value.taskCategories[index]),
                                ));
                          });
                },
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
