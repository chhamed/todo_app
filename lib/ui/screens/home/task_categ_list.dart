import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../controllers/provider/task_categorie.dart';
import '../../theme/my_text_styles.dart';
import '../../widgets/categorie_task_card.dart';

class TaskCategList extends StatelessWidget {
  const TaskCategList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "My Lists",
              style: MyTextStyles.headline1,
            ),
            Consumer<TaskCategorie>(
              builder: (context, value, child) => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 30.h,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: value.categTasks.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Draggable(
                      onDragStarted: () {
                        value.isDeleting();
                      },
                      onDraggableCanceled: (_, p) {
                        value.isDeleting();
                      },
                      data: value.categTasks[index],
                      feedback: SizedBox(
                        height: 30.h - 20,
                        width: 50.w - 20,
                        child: Opacity(
                          opacity: 0.6,
                          child: CategorieTaskCard(
                            taskCategorie: value.categTasks[index],
                          ),
                        ),
                      ),
                      child: CategorieTaskCard(
                        taskCategorie: value.categTasks[index],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
