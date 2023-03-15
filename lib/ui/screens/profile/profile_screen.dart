import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/controllers/provider/task_categorie_controller.dart';

import 'package:todo_app/ui/theme/my_text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var task = Provider.of<TaskCategorieController>(context, listen: false)
        ..countActive()
        ..countCompleted()
        ..countAll()
        ..rapport();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<TaskCategorieController>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Report",
                style: MyTextStyles.headline1,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.red, width: 2)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${value.activeCount}',
                            style: MyTextStyles.headline2
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Text(
                        "Active",
                        style: MyTextStyles.subhead,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.orange, width: 2)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${value.completedCount}',
                            style: MyTextStyles.headline2
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Text(
                        "Completed",
                        style: MyTextStyles.subhead,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.cyan, width: 2)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${value.allCount}',
                            style: MyTextStyles.headline2
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Text(
                        "Total",
                        style: MyTextStyles.subhead,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    value.completedTasksCount == null
                        ? CircularProgressIndicator()
                        : SizedBox(
                            height: 30.h,
                            width: 30.h,
                            child: TweenAnimationBuilder(
                              duration: const Duration(seconds: 1),
                              tween: Tween<double>(
                                  begin: 0, end: value.completedTasksCount),
                              builder: (context, double val, child) =>
                                  CircularProgressIndicator(
                                backgroundColor: Colors.grey.withOpacity(0.4),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.cyan),
                                strokeWidth: 15,
                                value: val,
                              ),
                            ),
                          ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${((value.completedTasksCount ?? 1) * 100).toInt()} %',
                          style: MyTextStyles.headline2
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Efficiency",
                          style:
                              MyTextStyles.subhead.copyWith(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
